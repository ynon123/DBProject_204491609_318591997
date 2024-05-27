
[General]
Version=1

[Preferences]
Username=
Password=2351
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=WEAPON
Count=1000

[Record]
Name=MODEL
Type=VARCHAR2
Size=20
Data=Company
Master=

[Record]
Name=SERIAL
Type=NUMBER
Size=
Data=Random(10000, 99999)
Master=

[Record]
Name=COMPANY
Type=VARCHAR2
Size=30
Data=Company
Master=

[Record]
Name=WEIGHT
Type=VARCHAR2
Size=20
Data=Random(1, 30) + ' kg'
Master=

[Record]
Name=ID
Type=NUMBER
Size=
Data=Random(1, 1000)
Master=

