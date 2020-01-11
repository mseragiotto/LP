import scala.actors.Actor
import scala.actors.Actor._

class MasterProcess extends Actor {

	def act() {		//start actor
		while(true){
			receive {
				case s: String => println(long_reverse_string(s))
			}	
		}
	}

	def long_reverse_string(string: String): String = {		//reverse method
		val length = string.length
		val nchar = length/10			//number of chars for substrings

		//list of indexes in which string had to slice
		val list = for (i <- nchar to length by nchar) yield i 	

		//list of substring to reverse
		val stringList: List[String] = lsplit(list.toList, string)
		for (i <- 0 to 9) {
			sendSubstring(i, (stringList drop i).head)	//send substring to slave processes
		}
		val result = new Array[String](10)	//prepare result array
		for (i <- 0 to 9) {
			receive {
				//set array with correct reversed substrings in reversed position
				case (id: Int, revString: String) => result.update(id,revString)	
			}		
		}
		result.mkString		//reversed string
	}

	//method that split input string by following indexes declared in a input list
	def lsplit(pos: List[Int], str: String): List[String] = {
  		val (rest, result) = pos.foldRight((str, List[String]())) {
    		case (curr, (s, res)) =>
    		val (rest, split) = s.splitAt(curr)
      		(rest, split :: res)
  		}
  		rest :: result
	}

	//method that create slave process and send it a numbered substring
	def sendSubstring(n: Int, string: String) {
		val slave = new SlaveProcess(9-n)
		slave.start
		slave ! string
	}
}


class SlaveProcess(id: Int) extends Actor {
	def act() {
		receive {
			//slave process receive reverse and send back string
			case s: String =>  sender ! (id, s.reverse)
		}
	}
}