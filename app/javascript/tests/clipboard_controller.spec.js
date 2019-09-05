import fs from 'fs'
import path from 'path'
import Clipboard from 'javascript/controllers/clipboard_controller'

describe('ClipboardController', () => {

  describe('copy', () => {
    document.body.innerHTML = fs.readFileSync(path.resolve(__dirname, 'fixtures/clipboard.html'), 'utf8');

    const source = document.querySelector('.target')
    const clipboard = new Clipboard()
    clipboard.sourceTarget = source

    it('value was set', () => {
      expect(clipboard.sourceTarget.value).toEqual(source.value)
      clipboard.copy()
      expect(document.execCommand.mock.calls[0][0]).toEqual('copy')
    });
  });
})
