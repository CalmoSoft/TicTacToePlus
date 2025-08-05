load "stdlib.ring"
load "guilib.ring"

C_ROWCOUNT = 15
C_COLCOUNT = 15
C_SPACING = 2
SqHeight  =  45
p=0
flag = 0
aReady = list(15,15)
C_ButtonEmptyStyle  = 'background-color: yellow; border-radius: 0px; '
aButtons = list(C_ROWCOUNT,C_COLCOUNT)
LayoutButtonRow = list(C_ROWCOUNT)

app = new qApp {
	StyleFusion()
	win = new qWidget() {
		setWindowTitle('TicTacToePlus Game')
		move(50,40) resize(600,600)
		setstylesheet('background-color:white')
		LayoutButtonMain = new QVBoxLayout()
		LayoutButtonMain.setSpacing(C_SPACING)
		LayoutButtonMain.setContentsmargins(0,0,0,0)
		for Row = 1 to C_ROWCOUNT
			LayoutButtonRow[Row] = new QHBoxLayout() {
				setSpacing(C_SPACING)
				setContentsmargins(0,0,0,0)
			}
			for Col = 1 to C_COLCOUNT
				aButtons[Row][Col] = new QPushButton(win) {
					setstylesheet('background-color:Yellow')
					setSizePolicy(1,1)
                                        setclickevent("showCell(" + string(Row) + "," + string(Col) + ")")
                                        settext("---")
                                        aReady[Row][Col] = 0
				}
				LayoutButtonRow[Row].AddWidget(aButtons[Row][Col])
			next
			LayoutButtonMain.AddLayout(LayoutButtonRow[Row])
		next
		setLayout(LayoutButtonMain)
                showmaximized()
		show()
	}
	exec()
}

func showCell(Row,Col)
     if flag%2 = 1
        pict = "White.jpg"
        pic=1
     else
        pict = "Black.jpg"
        pic=2
     ok
     flag = flag + 1

     aButtons[Row][Col] {
     if aButtons[Row][Col].text()= "---"
                           aButtons[Row][Col].settext("")
                           setIcon(new qIcon(new qPixMap(pict)))
                           setIconSize(new qSize(SqHeight,SqHeight))
                           setStyleSheet(C_ButtonEmptyStyle)         ### Needed to fill Square, image too small
                           setEnabled(true)
                           blockSignals(false)                       ### ??? Goes back to Complement Color ??
                           aReady[Row][Col] = pic    
     ok
                         }

checkWhiteWinner()
checkBlackWinner()
checCrossRightWhiteWinner()
checCrossLeftBlackWinner()

func checkWhiteWinner()
     for n = 1 to 15
         for m= 1 to 11
             flg = 0
             for p = 1 to 4
                 if aReady[n][m+p] = 1
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "White win!-1" + nl
              ok
          next
       next

     for n = 1 to 15
         for m= 1 to 11
             flg = 0
             for p = 1 to 4
                 if aReady[m+p][n] = 1
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "White win!-2" + nl
              ok
          next
       next

func checkBlackWinner()
     for n = 1 to 15
         for m= 1 to 11
             flg = 0
             for p = 1 to 4
                 if aReady[n][m+p] = 2
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "Black win!-1" + nl
              ok
          next
       next

     for n = 1 to 15
         for m= 1 to 11
             flg = 0
             for p = 1 to 4
                 if aReady[m+p][n] = 2
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "Black win!-2" + nl 
              ok
          next
       next

func checCrossRightWhiteWinner()
     for n = 1 to 11
         for m= 5 to 15
             flg = 0
             for p = 1 to 4
                 if aReady[n+p-1][m-p+1] = 1
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "White win!-3" + nl
              ok
          next
       next
 
    for n = 15 to 5 step - 1
         for m= 15 to 5 step - 1
             flg = 0
             for p = 1 to 4
                 if aReady[n-p+1][m-p+1] = 1
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "White win!-4" + nl
              ok
          next
       next

func checCrossLeftBlackWinner()
     for n = 1 to 11
         for m= 15 to 5 step - 1
             flg = 0
             for p = 1 to 4
                 if aReady[n+p-1][m-p+1] = 2
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "Black win!-3" + nl
              ok
          next
       next

     for n = 15 to 5 step - 1
         for m= 15 to 5 step - 1
             flg = 0
             for p = 1 to 4
                 if aReady[n-p+1][m-p+1] = 2
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "Black win!-4" + nl
              ok
          next
       next

