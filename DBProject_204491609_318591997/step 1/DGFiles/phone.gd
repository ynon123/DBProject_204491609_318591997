
[General]
Version=1

[Preferences]
Username=
Password=2276
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=PHONE
Count=10..20

[Record]
Name=PHONE_NUMBER
Type=VARCHAR2
Size=30
Data='+9725' [00000000]
Master=

[Record]
Name=TEL_COMPANY
Type=VARCHAR2
Size=20
Data=List( Pelephone,
=    Cellcom,
=    Partner,
=    HOT_Mobile,
=    Golan_Telecom,
=    019_Mobile,
=    We4G,
=    Rami_Levi_Communications,
=    Xfone,
=    YouPhone)
Master=

[Record]
Name=SMARTPHONE
Type=NUMBER
Size=
Data=Random(0, 1)
Master=

[Record]
Name=ID
Type=NUMBER
Size=
Data=Random(0, 1000)
Master=

