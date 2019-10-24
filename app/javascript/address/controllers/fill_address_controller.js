import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [ "zipCode", "pref", "city" ]

  connect() {
    this.proxyurl = "https://cors-anywhere.herokuapp.com/"
    this.baseUrl = 'http://zipcloud.ibsnet.co.jp'
    this.endPoint = '/api/search'
  }

  async fillIn() {
    const zipCode = this.zipCodeTarget.value
    const addresses = await this.fetchAddress(zipCode)
    this.prefTarget.value = addresses.address1
    this.cityTarget.value = addresses.address2
  }

  // 今回使うサイトは、レスポンスにCORSヘッダが付かないためJSでブロックされる。
  // そのため、レスポンスヘッダにCORSヘッダを付与するproxyurlを使う。
  // JavaScriptでのアクセスを想定されたAPI(CORSヘッダがあるAPI)なら不要。
  // GoogleMapsのAPIとかだと大丈夫。ただ、APIキーが必要。
  async fetchAddress(zipCode) {
    let url = new URL(this.endPoint, this.baseUrl)
    url.searchParams.set('zipcode', zipCode)
    const request = new Request(this.proxyurl + url, { method: "GET" })

    const response = await fetch(request).catch(() => false)
    const json = await response.json().catch(() => false)
    return json.results[0]
  }
}
