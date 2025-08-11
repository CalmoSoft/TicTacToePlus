load "stdlibcore.ring"
load "lightguilib.ring"

C_ROWCOUNT = 15
C_COLCOUNT = 15
C_SPACING = 2
SqHeight  =  45
p=0
flag = 0
aMap = list(15,15)

aReady = list(15,15)
C_ButtonEmptyStyle  = 'background-color: yellow; border-radius: 0px; '
aButtons = list(C_ROWCOUNT,C_COLCOUNT)
LayoutButtonRow = list(C_ROWCOUNT)

app = new qApp {
	StyleFusionBlack()
	win = new qWidget() {
	setWindowTitle('TicTacToePlus Game')
    setWinicon(self,"x.jpg")
	move(360,15)
	for Row = 1 to C_ROWCOUNT
		for Col = 1 to C_COLCOUNT
			aButtons[Row][Col] = new QPushButton(win) {
			setstylesheet('background-color:Yellow')
			setSizePolicy(1,1)
			setclickevent("showCell(" + string(Row) + "," + string(Col) + ")")
			settext("---")
            setgeometry(Row*40,Col*40,40,40)
	        aReady[Row][Col] = 0
		 	}
		next			
	next
	show()
	}
	exec()
}

func showCell(Row,Col)
	if flag%2 = 1
		pict = "o.jpg"
		pic=1
	else
		pict = "x.jpg"
		pic=2
	ok
	flag = flag + 1

	aButtons[Row][Col] {
		if aButtons[Row][Col].text()= "---"
			aButtons[Row][Col].settext("")
			setIcon(new qIcon(new qPixMap(pict)))
			setIconSize(new qSize(SqHeight,SqHeight))
			setstylesheet('background-color:Yellow')
			setEnabled(true)
			blockSignals(false)                       ### ??? Goes back to Complement Color ??
			aReady[Row][Col] = pic    
		ok
	}

checkWinner()

func checkWinner()
	lWin = False

	aMap = aReady

	C_WIDTH = 15
	C_HEIGHT = 15

	for nRow = 1 to C_HEIGHT
		for nCol = 1 to C_WIDTH
			cCell = aMap[nRow][nCol]
			if cCell = 0
				loop
			ok
			if ( nRow + 3 <= C_HEIGHT and cCell=aMap[nRow+1][nCol] and
				cCell=aMap[nRow+2][nCol] and cCell=aMap[nRow+3][nCol] ) OR

			   ( nCol + 3 <= C_WIDTH and cCell=aMap[nRow][nCol+1] and
				cCell=aMap[nRow][nCol+2] and cCell=aMap[nRow][nCol+3] ) OR

	           ( nRow + 3 <= C_HEIGHT and cCell=aMap[nRow+1][nCol+1] and
				cCell=aMap[nRow+2][nCol+2] and  cCell=aMap[nRow+3][nCol+3] ) OR

			   ( nRow > 3 and nCol <= (C_WIDTH-3)  and cCell=aMap[nRow-1][nCol+1] and
				cCell=aMap[nRow-2][nCol+2] and  cCell=aMap[nRow-3][nCol+3] )

			    lWin=True exit 2
			ok
		next
	next

	if lWin
		if cCell = 1
			msginfo("winner","O won!")
		but cCell = 2
			msginfo("winner","X won!")
		ok
		app.processEvents()
		sleep(1)
		newGame()
	ok

  
func newGame()
	delPict()

func delPict()
	for Row = 1 to C_ROWCOUNT
		for Col = 1 to C_COLCOUNT
			aButtons[Row][Col].setIcon(new qIcon(new qPixMap2(0,0)))
			aButtons[Row][Col].settext("---")
			aButtons[Row][Col].setstylesheet('background-color:Yellow')
			aReady[Row][Col] = 0
		next
	next



