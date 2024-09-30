import wollok.game.*

object hector {
	var property position = game.center()
	const property image = "player.png"
	const property plantacion = granja
	// SEMBRAR
	method sembrar(cultivo) {
		self.validarSembrar()
		cultivo.position(position)
		plantacion.agregarCultivo(cultivo)
		game.addVisual(cultivo)
	}

	method validarSembrar() {
		if (plantacion.hayCultivoEn(position)) {
			self.error("¡Ya hay un cultivo en esta parcela!")
		}
	}

	// REGAR
	method regar() {
		plantacion.cultivoAca().regar()
	}

	// COSECHAR

	// VENDER

	// ASPERSORES
}

object granja {
	const property cultivosSembrados = #{}

	method agregarCultivo(cultivo) {
		cultivosSembrados.add(cultivo)
	}

	method hayCultivoEn(posicion) {
		return !cultivosSembrados.filter({cultivo => cultivo.position() == posicion}).isEmpty()
	}

	method cultivoAca(posicion) {
		if (self.hayCultivoEn(posicion)) {
			return cultivosSembrados.find({cultivo => cultivo.positon() == posicion})
		} else {
			self.error("¡No hay cultivo para regar en la parcela!")
		}
	}
}