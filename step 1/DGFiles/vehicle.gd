
[General]
Version=1

[Preferences]
Username=
Password=2522
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=VEHICLE
Count=10..20

[Record]
Name=LICENSE_PLATE
Type=VARCHAR2
Size=10
Data=[000] '-' [00] '-' [000]
Master=

[Record]
Name=COLOR
Type=VARCHAR2
Size=10
Data=List(Red,
=    Blue,
=    Green,
=    Yellow,
=    Orange,
=    Purple,
=    Pink,
=    Brown,
=    Black,
=    White,
=    Gray,
=    Cyan,
=    Magenta,
=    Maroon,
=    Navy,
=    Teal,
=    Lavender,
=    Beige,
=    Olive,
=    Gold,
=    Silver,
=    Coral,
=    Turquoise,
=    Indigo,
=    Violet)
Master=

[Record]
Name=CAR_COMPANY
Type=VARCHAR2
Size=10
Data=List( Ford,
=    Toyota,
=    Honda,
=    Chevrolet,
=    Nissan,
=    BMW,
=    Mercedes,
=    Audi,
=    Volkswagen,
=    Subaru,
=    Hyundai,
=    Kia,
=    Mazda,
=    Lexus,
=    Jeep,
=    Tesla,
=    Volvo,
=    Mitsubishi,
=    Land Rover,
=    Porsche)
Master=

[Record]
Name=DATE_MANUACTURING
Type=DATE
Size=
Data=Ranom(01/01/1997, 01/01/2024)
Master=

