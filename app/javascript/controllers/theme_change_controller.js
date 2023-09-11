import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['dark', 'light'];

  initialize() {
    this.showCurrentIcon();
  }

  // Change the icons inside the button based on previous settings
  showCurrentIcon() {
    if (
      localStorage.getItem('color-theme') === 'dark' ||
      (!('color-theme' in localStorage) &&
        window.matchMedia('(prefers-color-scheme: dark)').matches)
    ) {
      this.darkTarget.classList.remove('hidden');
    } else {
      this.lightTarget.classList.remove('hidden');
    }
  }

  change(e) {
    // toggle icons
    this.darkTarget.classList.toggle('hidden');
    this.lightTarget.classList.toggle('hidden');

    // if set via local storage previously
    if (localStorage.getItem('color-theme')) {
      if (localStorage.getItem('color-theme') === 'light') {
        document.documentElement.classList.add('dark');
        localStorage.setItem('color-theme', 'dark');
      } else {
        document.documentElement.classList.remove('dark');
        localStorage.setItem('color-theme', 'light');
      }

      // if NOT set via local storage previously
    } else {
      if (document.documentElement.classList.contains('dark')) {
        document.documentElement.classList.remove('dark');
        localStorage.setItem('color-theme', 'light');
      } else {
        document.documentElement.classList.add('dark');
        localStorage.setItem('color-theme', 'dark');
      }
    }
  }
}
