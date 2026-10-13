class Pack {
    const duracion
    var coordinadorACargo
    const precio
    const beneficios = []

    method beneficios() = beneficios
    method precio() = precio
    method coordinadorACargo() = coordinadorACargo
    method cambiarCoordinador(nuevoCoordinador) {
        coordinadorACargo = nuevoCoordinador
    }
    method duracion() = duracion
    method actividades()
    method eliminarActividad(actividad)
    method agregarActividad(actividad)
    method provinciaDestino()
    method cantidadDeEscalas()
    method esLugarDeInteres()
    method paisDestino()
    method valorTotal() = self.precio() + self.beneficios().sum{n => n.costo()}
    method esPackPremiun() 
}

class Nacional inherits Pack {
    const provinciaDestino
    const actividades = []

    override method actividades() = actividades
    override method eliminarActividad(actividad) {
        if (self.actividades().contains(actividad)) {
            self.actividades().remove(actividad)
        }
    }
    override method agregarActividad(actividad) {
        if (not self.actividades().contains(actividad)) {
            self.actividades().add(actividad)
        }
    } 
    override method provinciaDestino() = provinciaDestino
    override method cantidadDeEscalas() {}
    override method esLugarDeInteres() {}
    override method paisDestino() {}
    override method esPackPremiun() = self.duracion() > 10 and self.coordinadorACargo().estaAltamenteCalificado()
}

class Internacional inherits Pack {
    const paisDestino 
    const esLugarDeInteres
    const cantidadDeEscalas

    override method actividades() {}
    override method eliminarActividad(actividad) {}
    override method agregarActividad(actividad) {}
    override method cantidadDeEscalas() = cantidadDeEscalas
    override method esLugarDeInteres() = esLugarDeInteres
    override method paisDestino() = paisDestino
    override method valorTotal() = super() * 1.20
    override method esPackPremiun() = self.esLugarDeInteres() and self.duracion() > 20 and self.cantidadDeEscalas()
}

class Coordinador {
    const estaMotivado
    var viajesRealizados
    const añosDeExperiencia
    const rolesDisponibles = ["guia", "asistenteLogistico", "acompañante"]
    var rol

    method rol() = rol
    method cambiarRol(nuevoRol){
        if (self.rolesDisponibles().contains(nuevoRol)) {rol = nuevoRol}
        else {self.error("Este rol no esta disponible.")}
    }
    method rolesDisponibles() = rolesDisponibles
    method añosDeExperiencia() = añosDeExperiencia
    method viajesRealizados() = viajesRealizados
    method agregarViajeRealizado() {
        viajesRealizados += 1
    }
    method estaMotivado() = estaMotivado
    method estaAltamenteCalificado() = self.viajesRealizados() > 20
}

class Guia inherits Coordinador(rol = "Guia"){
    override method estaAltamenteCalificado() = super() and self.estaMotivado()
}

class AsistenteLogistico inherits Coordinador(rol = "Asistente Logistico"){
    override method estaAltamenteCalificado() = super() and self.añosDeExperiencia() >= 3
}

class Acompañante inherits Coordinador(rol = "Acompañante"){
}

class BeneficioEspecial {
    const tipo
    const costo
    const estaVigente

    method tipo() = tipo
    method costo() = costo
    method estaVigente() = estaVigente
}