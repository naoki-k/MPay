export default class Follower {
  constructor(id, name) {
    this.id = id
    this.name = name
  }

  get html() {
    return `
    <li>
      <a href="/users/${this.id}"> ${this.name} </a>
      <span data-action="click->relationships#follow" value="${this.id}">申請許可</span>
    </li>
    `
  }
}
