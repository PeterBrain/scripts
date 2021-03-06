#https://github.com/ggmartins/dataengbb/tree/master/python/daemon

import os, sys
import datetime
import time
import daemon
import daemon.pidfile
import argparse
import signal
import logging

PROGNAME = 'monitor'
PATHCTRL = '/tmp/' #path to control files pid and lock
logpath = os.path.join(PATHCTRL, PROGNAME + ".log")
pidpath = os.path.join(PATHCTRL, PROGNAME + ".pid")
parser = argparse.ArgumentParser(prog = PROGNAME)

sp = parser.add_subparsers()
sp_start = sp.add_parser('start', help='Starts %(prog)s daemon')
sp_stop = sp.add_parser('stop', help='Stops %(prog)s daemon')
sp_status = sp.add_parser('status', help='Show the status of %(prog)s daemon')
sp_restart = sp.add_parser('restart', help='Restarts %(prog)s daemon')
sp_debug = sp.add_parser('debug', help='Starts %(prog)s daemon in debug mode')
sp_start.add_argument('-v', '--verbose', action='store_true', help='log extra informations')
sp_debug.add_argument('-v', '--verbose', action='store_true', help='log extra informations')

class MainCtrl:
    thread_continue = True
    thread_token = "token"
    log = None

    def getLogger(self):
        logging.basicConfig(
            format='%(asctime)s.%(msecs)03d %(levelname)s {%(module)s} [%(funcName)s] %(message)s',
            datefmt='%Y-%m-%dT%H:%M:%S',
            filename=logpath,
            #filemode='w',
            level=logging.INF
            )

        self.log = logging.getLogger("Main")
        return self.log

mainctrl = MainCtrl()

def main_thread_stop(signum=None, frame=None):
    mainctrl.thread_continue = False
    mainctrl.thread_token = "test"
    mainctrl.log.info("TOKEN:{0}".format(mainctrl.thread_token))

def main_thread(args, mainctrl):
    verbose = False

    if hasattr(args, 'verbose'):
        verbose = args.verbose

    log = mainctrl.getLogger()
    if verbose:
        log.info("ARGS:{0}".format(args))
    try:
        while mainctrl.thread_continue:
            if verbose:
                log.info("TOKEN:{0}".format(mainctrl.thread_token))
            time.sleep(1)

    except KeyboardInterrupt as ke:
        if verbose:
            log.warning("Interrupting...")

    except Exception as e:
        if verbose:
            log.error("Exception:{0}".format(str(e)))

    log.info("Exiting...")


def daemon_start(args=None):
    print("INFO: {0} Starting ...".format(PROGNAME))
    if os.path.exists(pidpath):
        print("INFO: {0} already running (according to {1}).".format(PROGNAME, pidpath))
        sys.exit(1)
    else:
        with daemon.DaemonContext(
                stdout=sys.stdout,
                stderr=sys.stderr,
                signal_map={
                    signal.SIGTERM: main_thread_stop,
                    signal.SIGTSTP: main_thread_stop,
                    signal.SIGINT: main_thread_stop,
                    #signal.SIGKILL: daemon_stop, #SIGKILL is an Invalid argument
                    signal.SIGUSR1: daemon_status,
                    signal.SIGUSR2: daemon_status,
                },
                pidfile = daemon.pidfile.PIDLockFile(pidpath)
        ):
            main_thread(args, mainctrl)


def daemon_restart(args):
    print("INFO: {0} Restarting...".format(PROGNAME))
    daemon_stop()
    time.sleep(1)
    daemon_start(args)


def daemon_stop(args=None):
    print("INFO: {0} Stopping with args {1}".format(PROGNAME, args))
    if os.path.exists(pidpath):
        with open(pidpath) as pid:
            try:
                os.kill(int(pid.readline()), signal.SIGINT)
            except ProcessLookupError as ple:
                os.remove(pidpath)
            print("ERROR ProcessLookupError: {0}".format(ple))
    else:
        print("ERROR: process isn't running (according to the absence of {0}).".format(pidpath))


def daemon_debug(args):
    print("INFO: running in debug mode.")
    main_thread(args, mainctrl)


def daemon_status(args):
    print("INFO: {0} Status {1}".format(PROGNAME, args))
    if os.path.exists(pidpath):
        print("INFO: {0} is running".format(PROGNAME))
    else:
        print("INFO: {0} is NOT running.".format(PROGNAME))


sp_stop.set_defaults(callback=daemon_stop)
sp_status.set_defaults(callback=daemon_status)
sp_start.set_defaults(callback=daemon_start)
sp_restart.set_defaults(callback=daemon_restart)
sp_debug.set_defaults(callback=daemon_debug)

args = parser.parse_args()

if hasattr(args, 'callback'):
    args.callback(args)
else:
    parser.print_help()
