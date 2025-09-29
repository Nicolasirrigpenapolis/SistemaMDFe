/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        // Sistema de cores adaptativo para tema claro/escuro
        'bg-primary': 'rgb(var(--color-bg-primary) / <alpha-value>)',
        'bg-surface': 'rgb(var(--color-bg-surface) / <alpha-value>)',
        'bg-surface-hover': 'rgb(var(--color-bg-surface-hover) / <alpha-value>)',
        'border-primary': 'rgb(var(--color-border-primary) / <alpha-value>)',
        'border-hover': 'rgb(var(--color-border-hover) / <alpha-value>)',
        'text-primary': 'rgb(var(--color-text-primary) / <alpha-value>)',
        'text-secondary': 'rgb(var(--color-text-secondary) / <alpha-value>)',
        'text-tertiary': 'rgb(var(--color-text-tertiary) / <alpha-value>)',
        'primary': {
          DEFAULT: 'rgb(var(--color-primary) / <alpha-value>)',
          hover: 'rgb(var(--color-primary-hover) / <alpha-value>)',
          light: 'rgb(var(--color-primary-light) / <alpha-value>)',
        },
        'success': {
          DEFAULT: 'rgb(var(--color-success) / <alpha-value>)',
          light: 'rgb(var(--color-success-light) / <alpha-value>)',
          dark: 'rgb(var(--color-success-dark) / <alpha-value>)',
        },
        'warning': {
          DEFAULT: 'rgb(var(--color-warning) / <alpha-value>)',
          light: 'rgb(var(--color-warning-light) / <alpha-value>)',
          dark: 'rgb(var(--color-warning-dark) / <alpha-value>)',
        },
        'danger': {
          DEFAULT: 'rgb(var(--color-danger) / <alpha-value>)',
          light: 'rgb(var(--color-danger-light) / <alpha-value>)',
          dark: 'rgb(var(--color-danger-dark) / <alpha-value>)',
        },
      },
      fontFamily: {
        sans: ['-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'sans-serif'],
      },
      animation: {
        'fade-in': 'fadeIn 0.2s ease-out',
        'slide-up': 'slideUp 0.2s ease-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { opacity: '0', transform: 'translateY(10px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
      },
    },
  },
  plugins: [],
}