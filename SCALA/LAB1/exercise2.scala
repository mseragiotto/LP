//comprehension

class Exercise2 {
	def squared_numbers(list: List[Any]): List[Any] = {
		var result: List[Any] = List();
		for (x <- list){
			x match {
				case x: Int => result = (x*x) :: result;
				case x: Double => result = (x*x) :: result;
				case x: Char => () :: result
				case l: List[Any] => result = squared_numbers(l) :: result;
				case _ => ();
			}
		} 
		result.reverse;
	}
}