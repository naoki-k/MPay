export default class Friend {
  constructor(id, name) {
    this.id = id
    this.name = name
  }

  get html() {
    return `
    <li>
      <a href="/users/${this.id}"> ${this.name} </a>
      <span data-action="click->relationships#unfollow" value="${this.id}">友達解除</span>
    </li>
    `
  }
}
