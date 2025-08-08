load "stdlibcore.ring"
load "lightguilib.ring"

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
	 move(50,40)
         resize(400,400)
	 setstylesheet('background-color:white')
         LayoutButtonRow = list(C_ROWCOUNT)
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
        setstylesheet('background-color:Yellow')
        setEnabled(true)
        blockSignals(false)                       ### ??? Goes back to Complement Color ??
        aReady[Row][Col] = pic    
     ok
     }

winner()

func winner()
     flgw = 0
     flgb = 0
     flgw1 = 0
     flgb1 = 0
     flgw2 = 0
     flgb2 = 0
     flgw3 = 0
     flgb3 = 0
     for n = 1 to 4
         if aReady[n][n] = 1
            flgw = flgw+1
         ok
         if aReady[n][n] = 2
            flgb = flgb+1
         ok
         if flgw=4
            msginfo("winner","White win!a")
            newGame()
         ok
         if flgb=4
            msginfo("winner","Black win!a")
            newGame()
         ok
         if aReady[15-n+1][n] = 1
            flgw1 = flgw1+1
         ok
         if aReady[15-n+1][n] = 2
            flgb1 = flgb1+1
         ok
         if flgw1=4
            msginfo("winner","White win!b")
            newGame()
         ok
         if flgb1=4
            msginfo("winner","Black win!b")
            newGame()
         ok
         if aReady[n][15-n+1] = 1
            flgw2 = flgw2+1
         ok
         if aReady[n][15-n+1] = 2
            flgb2 = flgb2+1
         ok
         if flgw2=4
            msginfo("winner","White win!c")
            newGame()
         ok
         if flgb2=4
            msginfo("winner","Black win!c")
            newGame()
         ok
         if aReady[15-n+1][15-n+1] = 1
            flgw3 = flgw3+1
         ok
         if aReady[15-n+1][15-n+1] = 2
            flgb3 = flgb3+1
         ok
         if flgw3=4
            msginfo("winner","White win!d")
            newGame()
         ok
         if flgb3=4
            msginfo("winner","Béack win!d")
            newGame()
         ok
      next

     for n = 1 to 15
         for m= 1 to 11
             flgw1 = 0
             flgw2 = 0
             flgb1 = 0
             flgb2 = 0             
             for p = 1 to 4
                 if aReady[n][m+p] = 1
                    flgw1 = flgw1+1
                 ok
                 if aReady[m+p][n] = 1
                    flgw2 = flgw2+1
                 ok
                 if aReady[n][m+p] = 2
                    flgb1 = flgb1+1
                 ok
                 if aReady[m+p][n] = 2
                    flgb2 = flgb2+1
                 ok
              next
              if flgw1=4
                 msginfo("winner","White win! e")
                 newGame()
              ok
              if flgw2=4
                 msginfo("winner","White win! e")
                 newGame()
              ok
              if flgb1=4
                 msginfo("winner","Black win!f")
                 newGame()
              ok
              if flgb2=4
                 msginfo("winner","Black win!f")
                 newGame()
              ok
          next
       next

     for n = 1 to 11
         for m= 5 to 15
             flg = 0
             for p = 1 to 4
                 if aReady[n+p-1][m-p] = 1
                    flg = flg+1
                 ok
              next
              if flg=4
                 see "White win!-3" + nl
                 msginfo("winner","White win!-3")
                 newGame()
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
                 msginfo("winner","White win!-4")
                 newGame()
              ok
          next
       next

     for n = 1 to 11
         for m= 15 to 5 step - 1
             flg = 0
             for p = 1 to 4
                 if aReady[n+p-1][m-p] = 2
                    flg = flg+1
                 ok
              next
              if flg=4
                 msginfo("winner","Black win!-3")
                 newGame()
              ok
          next
       next

     for n = 1 to 12 
         for m= 1 to 11 
             flg = 0
             for p = 1 to 4
                 if aReady[n+p-1][m+p-1] = 2
                    flg = flg+1
                 ok
              next
              if flg=4
                 msginfo("winner","Black win!-4")
                 newGame()
              ok
          next
       next

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
