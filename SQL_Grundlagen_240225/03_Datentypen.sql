/*
	3 große Gruppen:



	1. Charakter/String Datentypen:
	char(10) = 'Hallo     ' = 10 Byte Speicherplatz => UTF-8
	nchar(10) = 'Hallo     ' = 20 Byte Speicherplatz => UTF-16

	varchar(10) = 'Hallo' = 5 Byte Speicher
	nvarchar(10) = 'Hallo' = 10 Byte Speicher

	Legacy: text --> varchar(max) = bis zu 2 GB
	varchar(8000) / nvarchar(4000) sind maximum


	2. Numerischen Datentypen:
	tinyint = bis 255
	smallint = -32k bis 32k
	int = -2,14Mrd bis 2,14Mrd
	bigint = -9,2 Trillion bis 9,2 Trillion ca.

	bit = 1 oder 0 (True = 1, False = 0) => Es gibt kein Bool

	decimal(x, y) x Ziffern sind es gesamt, davon sind y Nachkommastellen
	decimal(10, 2) 10 Ziffern insgesamt, davon sind 2 Nachkommastellen

	money = ca 9,2 Trillion
	smallmoney = ca. 214 Tausend


	3. Datum/Zeit Datentypen:
	time = hh:mm:ss.nnnnnnn
	date = YYYY-MM-DD
	datetime = date + time in MS = YYYY-MM-DD hh:mm:ss.mmm
	datetime2 = YYYY-MM-DD hh:mm:ss.nnnnnnn
	smalldatetime = bis sekunden = YYYY-MM-DD hh:mm:ss

*/