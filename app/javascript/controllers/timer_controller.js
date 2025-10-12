import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "minutes"]
  static values = { delay: Number, message: String, enabled: Boolean }

  connect() {
    const defaultDelay = 25 * 60 * 1000
    this.baseDelay = this.delayValue || defaultDelay

    if (this.enabledValue) {
      this.startWithDelay(this.baseDelay)
    } else {
      this.setDisplayFromMs(this.baseDelay)
    }
  }

  disconnect() {
    this.clearTimers()
  }

  startWithDelay(ms) {
    this.clearTimers()
    this.endAt = Date.now() + ms
    this.updateDisplay()
    this.interval = setInterval(() => this.updateDisplay(), 1000)
  }

  clearTimers() {
    if (this.interval) clearInterval(this.interval)
    this.interval = null
  }

  updateDisplay() {
    const remaining = (this.endAt ?? 0) - Date.now()
    if (!this.endAt || remaining <= 0) {
      this.clearTimers()
      this.setDisplayFromMs(0)
      alert(this.messageValue || "时间到了！")
      return
    }
    this.setDisplayFromMs(remaining)
  }

  setDisplayFromMs(ms) {
    const totalSeconds = Math.max(0, Math.ceil(ms / 1000))
    const minutes = Math.floor(totalSeconds / 60)
    const seconds = totalSeconds % 60
    const mm = String(minutes).padStart(2, "0")
    const ss = String(seconds).padStart(2, "0")
    if (this.hasDisplayTarget) this.displayTarget.textContent = `${mm}:${ss}`
  }

  // 输入分钟数，更新基础时长但不立即开始
  updateMinutes(event) {
    const minutes = parseFloat(event.target.value)
    if (Number.isFinite(minutes) && minutes > 0) {
      this.baseDelay = Math.round(minutes * 60 * 1000)
      if (!this.interval) this.setDisplayFromMs(this.baseDelay)
    }
  }

  // 点击开始，按当前基础时长启动
  start() {
    const ms = this.baseDelay || 25 * 60 * 1000
    this.startWithDelay(ms)
  }

  // 停止计时
  stop() {
    this.clearTimers()
  }
}