//Functional Scala
import scala.util.matching.Regex

class Exercise1 {
	def is_palindrome(str: String): Boolean = {
		val pattern = new Regex("\\,|\\;|\\.|\\:|\\-|\\_|\\?|\\!|\\s")
		val cleanStr = pattern replaceAllIn(str.toLowerCase,"")
		cleanStr == cleanStr.reverse
	}

	private def check_anagram(S: String, L: List[String]): List[Boolean] = 
		L match {
			case Nil => Nil
			case hd::tl => ((S.permutations.toList) contains hd)::(check_anagram(S,tl))
		}

	def is_an_anagram(str: String, dict: List[String]): Boolean = 
		check_anagram(str, dict) contains true
}

