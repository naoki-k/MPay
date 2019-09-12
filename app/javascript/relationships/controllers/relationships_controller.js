import { Controller } from "stimulus"
import Flash from "../../flash/models/flash"

export default class extends Controller {

  follow() {
    this.fetch_and_notify(`/relationships/${this.data.get('id')}`, 'POST')
  }

  unfollow() {
    this.fetch_and_notify(`/relationships/${this.data.get('id')}`, 'DELETE')
  }

  async fetch_and_notify(url, method, flash_node) {
    const request = new Request(url, {
      method: method,
    })

    const response = await fetch(request)
    if(response && response.status == 200) {
      const flash = new Flash('success', '友達リクエストを承認しました。')
      flash.show()
    } else {
      const flash = new Flash('danger', '通信エラー')
      flash.show()
    }
  }
}
