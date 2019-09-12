// run with flash_controller
// flash-containerクラスを与えたエレメントを表示したい場所に用意する必要があります

export default class Flash {
  constructor(status, message) {
    this.status = status
    this.message = message
  }

  show() {
    const node = document.createElement('div')
    node.innerHTML = `<div data-controller='flash', data-flash-status="${this.status}", data-flash-message="${this.message}"/>`
    document.body.appendChild(node)
    setTimeout(()=>{
      document.body.removeChild(node)
    }, 3000)
  }
}
