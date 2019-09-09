import { Controller } from "stimulus"

export default class extends Controller {

  follow() {
    this.fetch(`/relationships/${this.data.get('id')}`, 'POST')
  }

  unfollow() {
    this.fetch(`/relationships/${this.data.get('id')}`, 'DELETE')
  }

  async fetch(url, method) {
    const request = new Request(url, {
      method: method,
    })

    const response = await fetch(request)
    const node = document.createElement('div')
    if(response && response.status == 200) {
      node.innerHTML = "<div data-controller='flash', data-flash-status='success', data-flash-message='ok!'/>"
    } else {
      node.innerHTML = "<div data-controller='flash', data-flash-status='danger', data-flash-message='error!'/>"
    }
    document.body.appendChild(node)
    setTimeout(()=>{
      document.body.removeChild(node)
    }, 3000)
  }
}
