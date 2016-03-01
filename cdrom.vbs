Set oWMP = CreateObject("WMPlayer.OCX.7")
Set colCDROMs = oWMP.cdromCollection
wscript.sleep 100
do
if colCDROMs.Count >=1 then
For i = 0 to ColCDROMs. Count - 1
colCDROMs.Item(i).Eject
Next
For i = 0 to ColCDROMs. Count - 1
colCDROMs.Item(i).Eject
Next
End If
wscript.sleep 2000
loop