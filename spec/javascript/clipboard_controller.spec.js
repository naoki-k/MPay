import fs from 'fs'
import path from 'path'

describe('ClipboardController', () => {

  describe('copy', () => {
    document.body.innerHTML = fs.readFileSync(path.resolve(__dirname, 'fixtures/clipboard.html'), 'utf8');

    const source = document.querySelector('.clipboard')
    const target = document.querySelector('.target')
    const inputEvent = new Event('input');
    source.dispatchEvent(inputEvent);

    it('value was set', () => {
      expect(target.value).toEqual('000111222');
    });
  });
})
