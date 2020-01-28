import requests
import re
import sys

# Initial work from: https://mpetroff.net/2016/07/new-amazon-dash-button-teardown-jk29lp/

# python dashbutton_setup.py "SSID" "Password"

h = requests.Session()

BASE_URL = "http://192.168.0.1"


def wait_for_device():
    print("* Long press the dash button until LED light blinks in blue")
    print('* Connect to Wifi with SSID "Amazon ConfigureMe"')
    print("* Waiting for connection...")
    while True:
        try:
            r = h.get(BASE_URL, timeout=10)
            #print(r.content)

            if "Amazon Dash" in r.text:
                break
        except:
            pass
        else:
            break
    print("+ Connected!")
    content = r.text
    serial = re.findall("Serial Number</th>[^/]+>([A-Z0-9_]+)</td", content, re.DOTALL)[0]
    mac = re.findall("MAC Address</th>[^/]+>([A-Z0-9_]+)</td", content, re.DOTALL)[0]
    firmware = re.findall("Firmware</th>[^/]+>([A-Z0-9_]+)</td", content, re.DOTALL)[0]
    battery = re.findall("Battery</th>[^/]+>([A-Z0-9_]+)</td", content, re.DOTALL)[0]

    print(
        "* Serial: %s, MAC: %s, Firmware: %s, Battery: %s"
        % (serial, mac, firmware, battery)
    )

    return mac


def configure_wifi(ssid, password):
    print('* Configure Dash button to connect to "%s"' % ssid)
    # is the ssid in range ?
    """r = h.get(BASE_URL, headers={"Content-Type": "application/json"}, timeout=5)
    amzn_networks = r.json()["amzn_networks"]
    found = False
    for amzn_network in amzn_networks:
        if amzn_network["ssid"] == ssid:
            found = True
            break
    if not found:
        print("- SSID %s is not discoverable by Dash button" % ssid)
        return"""
    print("%s/?amzn_ssid=%s&amzn_pw=%s" % (BASE_URL, ssid, password))
    r = h.get("%s/?amzn_ssid=%s&amzn_pw=%s" % (BASE_URL, ssid, password), timeout=5)
    if r.status_code == 200:
        print("+ Dash button configured!")
        return True


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: setup.py WIFI_SSID WIFI_PASSWORD")
        sys.exit(1)
    try:
        wait_for_device()
        configure_wifi(sys.argv[1], sys.argv[2])
    except KeyboardInterrupt:
        print("Bye")
