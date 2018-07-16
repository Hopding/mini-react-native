const global = Function('return this')()

class Producer {
    produce() {
        log("OMG FOO")
        log(Object.keys(global))
        return [
                { type: 'Button', color: 'red',     title: 'FOO' },
                { type: 'Button', color: 'green',   title: 'BAR' },
                { type: 'Button', color: 'blue',    title: 'QUX' },
                { type: 'Button', color: 'purple',  title: 'BAZ' },
                genButton(),
        ]
    }
    
    handleButtonPress() {
        log("OMG BUTTON PRESSED")
    }
}
