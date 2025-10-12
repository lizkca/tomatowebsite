import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]
  static values = { delay: Number, message: String, enabled: Boolean }

  connect() {
    if (this.enabledValue === false) return
    const delay = this.delayValue || 300000
    this.endAt = Date.now() + delay
    this.updateDisplay()
    this.interval = setInterval(() => {
      this.updateDisplay()
    }, 1000)
  }

  disconnect() {
    if (this.interval) clearInterval(this.interval)
  }

  updateDisplay() {
    const remaining = this.endAt - Date.now()
    if (remaining <= 0) {
      if (this.interval) clearInterval(this.interval)
      if (this.displayTarget) this.displayTarget.textContent = "00:00"
      alert(this.messageValue || "5分钟到了！")
      return
    }
    const totalSeconds = Math.ceil(remaining / 1000)
    const minutes = Math.floor(totalSeconds / 60)
    const seconds = totalSeconds % 60
    const mm = String(minutes).padStart(2, "0")
    const ss = String(seconds).padStart(2, "0")
    if (this.displayTarget) {
      this.displayTarget.textContent = `${mm}:${ss}`
    }
  }
}