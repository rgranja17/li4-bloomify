/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./**/*.razor",
    "./**/*.cshtml",
    "./**/*.html",
  ],
  theme: {
    extend: {
      fontFamily: {
        outfit: ["Outfit", "sans-serif"],
      },
      colors: {
        custom_green: "#3F784C",
        custom_dark_green: "#164D23",
        profile_green: "#164D23",
        custom_gray: "#D9D9D9",
        custom_light_gray: "#D4D1D1",
        custom_purple: "#783F6B",
      },
      keyframes: {
        'pulse-soft': {
          '0%, 100%': { transform: 'scale(1)' },
          '50%': { transform: 'scale(2)' },
        },
        'pulse-bounce': {
          '0%, 100%': { transform: 'translateY(0)' },
          '50%': { transform: 'translateY(-10px)' },
        },
        'pulse-color': {
          '0%, 100%': { 
            transform: 'scale(1)',
            color: 'var(--custom-green)', // Use CSS variable for custom color
          },
          '50%': { 
            transform: 'scale(1.5)', // Reduced scale for a softer effect
            color: '#164D23', // A different shade of green
          },
        },
        'vibrate': {
          '0%': { transform: 'translate(0px, 0px)' },
          '25%': { transform: 'translate(2px, -2px)' },
          '50%': { transform: 'translate(-2px, 2px)' },
          '75%': { transform: 'translate(2px, 2px)' },
          '100%': { transform: 'translate(0px, 0px)' },
        },
      },
      animation: {
        'pulse-soft': 'pulse-soft 2s ease-in-out infinite',
        'pulse-bounce': 'pulse-bounce 1s ease-in-out infinite', // Updated bounce animation
        'pulse-color': 'pulse-color 12s ease-in-out infinite', // Slower animation speed
        'bounce-slow': 'bounce 2s infinite', 
        'vibrate': 'vibrate 2s linear infinite', 
        'bounce-slowest': 'bounce 4s infinite',
      },
    },
  },
  plugins: [],
};
