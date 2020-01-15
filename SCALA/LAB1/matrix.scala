/*

The class should be parametric on its dimensions and will provide the operations of 
 matrix equivalence,
 matrix copy,
 matrix addition,
 scalar-matrix multiplication,
 matrix-matrix multiplication, 
 matrix transposition, and 
 matrix norm -- the "size" of a matrix. 
Override the appropriate operators and raise the appropriate exceptions.

Let aij denote the i,j-th element of matrix A, located at row i, column j. 

*/

class Matrix(val n: Int, val m: Int) {
	val content = Array.ofDim[Int](n,m)
	
	def insert(vals: Int*) {
		if(vals.length>(n*m) || vals.length<(n*m)) {
			throw new IllegalArgumentException
		}
		var aux = vals
		for (i <- 0 to n-1; j <- 0 to m-1) {
			content(i)(j) = aux.head
			aux = aux drop 1
		}
	}

	def stamp() {
		if(!content.isEmpty){
			for (i <- 0 to n-1) {
				print("\n")
				for (j <- 0 to m-1) {
					print(content(i)(j)+"\t")
				}
			}			
		} else {
			throw new IllegalArgumentException
		}
	}

	/*
	matrix equivalence 
	A ≃ B where A in Zm×n, B in Zp×q when m = p and
	n = q and bij = aij for i = 1,...,m j = 1,...,n;
	*/

	def equivalence(m2: Matrix): Boolean = {
		if(m2.n == n && m2.m == m) {
			for(i <- 0 to n-1; j <- 0 to m-1) {
				if(content(i)(j) != m2.content(i)(j)) {
					return false
				}
			}
			return true
		} else { 
			return false 
		}
	}

	/*
	matrix copy 
	B = A where A, B in Zm×n (bij = aij for i = 1,...,m j = 1,...,n);
	*/

	def copy(): Matrix = {
		val newM = new Matrix(n,m)
		for (i <- 0 to n-1; j <- 0 to m-1) {
			newM.content(i)(j) = content(i)(j)
		}
		return newM
	}

	/*
	matrix addition 
	C = A + B where A, B, C in Zm×n (cij = aij + bij for i = 1,...,m j = 1,...,n);
	*/

	def addition(mat: Matrix): Matrix = {
		if(mat.n == n && mat.m == m) {
			val newM = new Matrix(n,m)
			for (i <- 0 to n-1; j <- 0 to m-1) {
				newM.content(i)(j) = content(i)(j) + mat.content(i)(j)
			}
			return newM
		} else {
			throw new IllegalArgumentException
		}
	}

	/*
	scalar-matrix multiplication 
	B = aA where A, B in Zm×n, a in Z (bij = a·aij for i = 1,...,m j = 1,...,n);
	*/

	def scalar_mult(mul: Int): Matrix = {
		val newM = new Matrix(n,m)
		for (i <- 0 to n-1; j <- 0 to m-1) {
			newM.content(i)(j) = content(i)(j) * mul
		}
		return newM
	}	

	/*
	matrix-matrix multiplication 
	C = A·B where A in Zm×p, B in Zp×n, 
	C in Zm×n (cij = Σk=1, ..., p aik·bkj for i = 1,...,m j = 1,...,n);
	*/

	def multiplication(m2: Matrix): Matrix = {
		if(m == m2.n) {
			var aux = List[Int]()
			val newM = new Matrix(n,m2.m)
			val trs = m2.transposition()
			for(i <- 0 to n-1; j <- 0 to n-1) {
				var row = content(i)
				var col = trs.content(j)
				var elem = 0
				for(k <- 0 to m-1) {
					elem += (row(k)*col(k))
				}
				aux = elem :: aux
			}
			aux = aux.reverse
			for (i <- 0 to n-1; j <- 0 to m2.m-1) {
				newM.content(i)(j) = aux.head
				aux = aux drop 1
			}
			return newM
		} else { 
			throw new IllegalArgumentException
		}
	}

	/*
	matrix transposition 
	B = AT where A in Zm×n, B in Zn×m (bji = aij for i = 1,...,m j = 1,...,n);
	*/

	def transposition(): Matrix = {
		var nlist = List[Int]()
		for(j <- 0 to m-1; i <- 0 to n-1) {
			nlist = content(i)(j) :: nlist
		}
		nlist = nlist.reverse
		val newM = new Matrix(m,n)
		for (i <- 0 to m-1; j <- 0 to n-1) {
			newM.content(i)(j) = nlist.head
			nlist = nlist drop 1
		}
		return newM
	}

	/*
	matrix norm (matrix 1-norm) 
	a = ‖A‖ where a in Z, A in Zm×n (a = maxj Σi | aij | for i = 1,...,m j = 1,...,n).
	*/
}