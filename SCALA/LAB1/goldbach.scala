class Exercise6 {
  def goldbach(n: Int): Tuple2[Int,Int] = {
    if((n % 2) != 0 || n < 2){
      println("n is not even\n")
      (-1,-1)
    }
    else{
       var primeList = getPrimes(n)
       val auxList = getPrimes(n)
       for(i <- 0 to auxList.length) {
          println("primeList = "+primeList)
          println("check "+n+" - "+primeList.head)
          if(auxList.contains(n-primeList.head)) {
            println(" -> true")
            return new Tuple2(n-primeList.head, primeList.head)
          }
          else {
            println(" -> false")
            primeList = primeList drop 1
          }
       }
       new Tuple2(-1,-1)

    }
  }

  private def getPrimes(n: Int): List[Int] = {
    val nNew = (n-2)/2
    val marked = new Array[Boolean](n)
    for(k <- 0 to n-1){
      marked.update(k, false)
    }
    var j = 0
    for(i <- 1 to nNew){
      j = i
      while((i+j+2*i*j)<= nNew){
        marked.update((i+j+2*i*j), true)
        j+=1
      }
    }
    var result = List[Int](2)
    for(i <- 1 to nNew){
      if(marked(i)==false)
        result = (2*i+1) :: result
    }
    result.reverse
  }
}