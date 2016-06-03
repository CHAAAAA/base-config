package base.config

class ClosureScript extends Script {
    Closure closure
    def run() {
        closure.resolveStrategy = Closure.DELEGATE_FIRST
        closure.delegate = this
        closure.call()
    }
}
