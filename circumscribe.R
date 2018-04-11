dracirc=function(A,B,C){
  circ<-circumcircle2(A,B,C)
  O<-c(circ$x,circ$y)
  ro<-dist(rbind(circ$a,O))
  plot.new()
  lines(x=O[1]+ro*sin(2*pi*seq(0,1,le=180)),
        y=O[2]+ro*cos(2*pi*seq(0,1,le=180)))}


# -------------------------------------
circumcircle2<-function(a, b, c) {
  #a,b,c are x,y cartesian pairs, i.e. a<-c(x,y)
  this<-list()
  this$a <- a
  this$b <- b
  this$c <- c
  
  EPSILON <- 1.0 / 1048576.0
  ax <- a[1]
  ay <- a[2]
  bx <- b[1]
  by <- b[2]
  cx <- c[1]
  cy <- c[2]
  fabsy1y2 <- abs(ay - by)
  fabsy2y3 <- abs(by - cy)
  

# Check for coincident points
  if(fabsy1y2 < EPSILON & fabsy2y3 < EPSILON){
      stop("Eek! Coincident points!")
  }
  
  if(fabsy1y2 < EPSILON) {
    m2  <- -((cx - bx) / (cy - by))
    mx2 <- (bx + cx) / 2.0
    my2 <- (by + cy) / 2.0
    xc  <- (bx + ax) / 2.0
    yc  <- m2 * (xc - mx2) + my2
  } else
    if(fabsy2y3 < EPSILON){
      m1  <- -((bx - ax) / (by - ay))
      mx1 <- (ax + bx) / 2.0
      my1 <- (ay + by) / 2.0
      xc  <- (cx + bx) / 2.0
      yc  <- m1 * (xc - mx1) + my1
    }
   else {
    m1  <- -((bx - ax) / (by - ay))
    m2  <- -((cx - bx) / (cy - by))
    mx1 <- (ax + bx) / 2.0
    mx2 <- (bx + cx) / 2.0
    my1 <- (ay + by) / 2.0
    my2 <- (by + cy) / 2.0
    xc  <- (m1 * mx1 - m2 * mx2 + my2 - my1) / (m1 - m2)
    yc  <- (fabsy1y2 > fabsy2y3)
    m1 * (xc - mx1) + my1
    m2 * (xc - mx2) + my2
  }
  
  
  dx <- bx - xc
  dy <- by - yc
  this$x <- xc
  this$y <- yc
  this$r <- sqrt(dx * dx + dy * dy)
  return(this)
  
}
