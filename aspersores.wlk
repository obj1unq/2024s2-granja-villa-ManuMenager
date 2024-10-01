import wollok.game.*

object aspersores {
	
	const property todos = #{} 
	
	method crear(position, plantacion) {
		const aspersor = new Aspersor(position=position, plantacion=plantacion)
		todos.add(aspersor)
		game.addVisual(aspersor)
	}
	
	method activar() {
		todos.forEach({aspersor => aspersor.activar()})
	}
	
}

class Aspersor {
    var property position = null
    const plantacion = null

    method image() {
        return "aspersor.png"
    }

    method activar() {
		self.vecinos().forEach({_position => self.regar(_position)}) 
	}
	
	method vecinos() {
		return (-1..1).map({deltaX => (-1..1).map({ deltaY=> 
            const x = position.x() + deltaX 
            const y = position.y() + deltaY 
            return game.at(x,y)})})
			.flatten() 
			.filter({pos => pos != position}) 
	}
	
	method regar(_position) {
		plantacion.sembrados(_position).forEach({cultivo => cultivo.regar()})
	}
}