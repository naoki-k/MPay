export default class BrowsedPlaces {
  static URL = '/browsed_places'

  constructor(limit, withoutPlaceId) {
    this.limit = limit
    this.withoutPlaceId = withoutPlaceId
  }

  async listViewHtml() {
    const fetchHtml = async () => {
      const request = new Request(this.url, { method: 'GET' })
      const response = await fetch(request).catch(() => { throw new Error() })
      if (!response.ok) throw new Error()

      const json = await response.json().catch(() => { throw new Error() })
      return json.results[0]
    }

    const html = await fetchHtml().catch(() => null )
    return html
  }

  get url() {
    const url = new URL(BrowsedPlaces.URL, window.location.href)
    if (this.limit) url.searchParams.set('limit', this.limit)
    if (this.withoutPlaceId) url.searchParams.set('without_place_id', this.withoutPlaceId)
    return url
  }
}
