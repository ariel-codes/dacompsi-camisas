const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
    content: [
        './public/*.html',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/views/**/*.{erb,haml,html,slim}'
    ],
    theme: {
        extend: {
            fontFamily: {
                sans: ['Inter var', ...defaultTheme.fontFamily.sans],
            },
            colors: {
                "brand": {
                    50: "#FFE0E4",
                    100: "#FFC2C9",
                    200: "#FF8593",
                    300: "#FF475D",
                    400: "#FF0A27",
                    500: "#C90019",
                    600: "#A30013",
                    700: "#7A000E",
                    800: "#52000A",
                    900: "#290005"
                }
            }
        },
    },
    plugins: [
        require('@tailwindcss/forms'),
        require('@tailwindcss/aspect-ratio'),
        require('@tailwindcss/typography'),
    ]
}
