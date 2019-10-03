import { Controller } from "stimulus"

export default class FlashController extends Controller {

  initialize() {
    this.node = document.createElement('div')
    this.container = document.querySelector('.flash-container')
  }

  connect() {
    this.node.setAttribute('class', 'flash-message')
    this.node.innerHTML = `
    <div class='flash-message__${this.data.get('status')}'>
      <div class='flash-message__container'>${this.data.get('message')}</div>
    </div>
    `
    this.container.appendChild(this.node)
  }

  disconnect() {
    this.container.removeChild(this.node)
  }
}
