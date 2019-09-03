import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "keyword" ]

  search() {
    console.log(this.keywordTarget)
    const data = new FormData();
    data.append("keyword", this.keywordTarget.value)
    const request = new Request("/user_search", {
      method: "POST",
      body: data
    })

    fetch(request).then((response => {
      console.log(response)
    }))
  }
}
