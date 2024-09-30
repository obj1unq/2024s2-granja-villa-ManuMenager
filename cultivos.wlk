import wollok.game.*

class Maiz {
	var property estado = baby
	var property position = null

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_baby.png"
	}

	method regar() {
		estado = adult
	}
}

object baby {
}

object adult {
}

class Trigo {
	var property position = null
	var estado = 0
	

	method image() {
		return "wheat_"+ estado + ".png"
	}

	method regar() {
		if (estado < 3) {
			estado += 1
		} else {
			estado = 0
		}
	}
}

class Tomaco {
	var property position = null

	method image() {
		return "tomaco.png"
	}

	method regar() {
		position = game.at(position.x(), self.siguienteY())
	}

	method siguienteY() {
		if (game.height() - 1 != position.y()) {
			return position.y() + 1
		} else {
			return 0
		}
	}
}