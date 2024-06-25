object formacion {
	const vagonesDelTren = []
	const locomotoras = []
	var property cantVagones = vagonesDelTren.size()
	var property cantVagonPopular = 0 
	var cantidadTotalPasajeros
	method agregarVagon(nombre) {
		vagonesDelTren.add(nombre)
		cantVagonPopular = if(nombre.cantidadDePasajeros() > 50) cantVagonPopular + 1 else cantVagonPopular 
	} // esta bien
	method formacionVagon() {
		return vagonesDelTren
	} // esta bien 
	method agregarLocomotora(nombre){
		locomotoras.add(nombre)
	} // esta bien 
	method locomotoras(){
		return locomotoras
	}
	method esCarguera(){
		return vagonesDelTren.all({cosa => cosa.cargaMaxima() > 1000})
	} //esta bien
	method dispersionDePesos(){
		const dispersionMax = vagonesDelTren.max({ cosa => cosa.peso()})
		//var dipersionMin = vagonesDelTren.max({ cosa => cosa.peso()} and  not (dispersionMax))
		//var res = dispersionMax.peso() - dipersionMin.peso() 
		return dispersionMax
	} // creo que esta bien 
	method cantidadDePasajeros(){
		cantidadTotalPasajeros = vagonesDelTren.sum({cosa => cosa.cantidadDePasajeros()})
		return cantidadTotalPasajeros
	} //esta bien
	method cantBaniosTotal(){
		 return vagonesDelTren.filter({cosa => cosa.tieneBanios()}).size()
	}	// esta bien
	method hacerMantenimiento(){
		vagonesDelTren.forEach({cosa => if (not(cosa.estaOrdenado())) cosa.cambioDeOrden() })
		vagonesDelTren.forEach({cosa => cosa.cantMaderasSueltas(- 2)})
	}
	method estaEquilibrada(){
		var dispersionMax = vagonesDelTren.max({ cosa => cosa.peso()}).peso()
		var dipersionMin = vagonesDelTren.max({ cosa => cosa.peso() < dispersionMax }).peso()
		var res = dispersionMax - dipersionMin
		return res < 20
		}
	method velocidadMaxLocomotoras(){
		return locomotoras.min({cosa => cosa.velocidadMax()}).velocidadMax()
	} // me devuelve el minimo, no se si era asi el ejercicio
	method sonEficientes(){
		return locomotoras.all({cosa => cosa.esEficiente()})
	} // funciona
	method puedeMover() = locomotoras.sum({cosa=> cosa.pesoQuePuedeArrastrar()}) > locomotoras.max({cosa => cosa.peso()}).peso() // me devuelve true, no se que habia que hacer
	method kilosDeEmpujeFaltantes() = if (self.puedeMover()) 0 else locomotoras.max({cosa => cosa.peso()}).peso() - locomotoras.sum({cosa=> cosa.pesoQuePuedeArrastrar()}) // devuelve que falta 0
}
	//- Cuántos _kilos de empuje le faltan_ para poder moverse, que es: 0 si ya se puede mover, y si no, el resultado de: peso máximo - suma de arrastre de cada locomotora.
class VagonDePasajeros {
	var property  largo
	var property ancho
	var property peso
	var property tieneBanios = true
	var property estaOrdenado = true
	var cantidadDePasajeros
	var property cargaMaxima = if(tieneBanios) 300 else 800

	method noTienebanios(){
		tieneBanios = not(tieneBanios)
	}
	method cantidadDePasajeros() {
	cantidadDePasajeros = if (ancho <= 3) 8 * largo else 10 
	cantidadDePasajeros  = if(estaOrdenado) cantidadDePasajeros else cantidadDePasajeros - 15 
	return cantidadDePasajeros  
	}
	method cambioDeOrden(){
		estaOrdenado = not(estaOrdenado )
	}

}
class VagonDeCarga {
	var property cargaMaxIdeal
	var property cantMaderasSueltas
	const property puedeLlevarPasajeros = false
	const property tieneBanios = false
	var property carga = cargaMaxIdeal - 400 * cantMaderasSueltas
	const property pesoMaximo = 1500 + cargaMaxIdeal
	const property cantidadDePasajeros = 0

}
class VagonDormitorio{
	var property cantCompartimientos
	var property cantCamasPorCompartimiento
	const property tienebanios = true
	const property carga = 1200
	var property cantPasajeros = cantCompartimientos * cantCamasPorCompartimiento
	var property pesoMax = 4000 + 80 *cantPasajeros + carga

}
class Locomotoras {
	var property peso 
	var property pesoQuePuedeArrastrar
	var property velocidadMax
	method esEficiente() = pesoQuePuedeArrastrar >= peso * 5
}