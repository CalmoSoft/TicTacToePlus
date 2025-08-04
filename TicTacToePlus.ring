load "stdlib.ring"
load "guilib.ring"

C_ROWCOUNT = 15
C_COLCOUNT = 15
C_SPACING = 2
SqHeight  =  45
p=0
flag = 0
aReady = list(15,15)
C_ButtonEmptyStyle  = 'background-color: rgba(220,177,107,255); border-radius: 0px; '
aButtons = list(C_ROWCOUNT,C_COLCOUNT)
LayoutButtonRow = list(C_ROWCOUNT)

app = new qApp {
	StyleFusion()
	win = new qWidget() {
		setWindowTitle('Resizing buttons in Layout')
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
        p=1
     else
        pict = "Black.jpg"
        p=2
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
                           aReady[Row][Col] = p    
     ok
                         }

checkWhiteWinner()
checkBlackWinner()

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
                 see "White win!"
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
                 see "White win!"
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
                 see "Black win!"
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
                 see "Black win!"
              ok
          next
       next



