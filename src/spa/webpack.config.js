const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  mode: 'production',
  entry: {
    app: './public/js/app.js' // Seul app.js est spécifié comme point d'entrée
  },
  output: {
    filename: '[name].bundle.js', // Utilisez [name] pour générer des noms de fichier dynamiques
    path: path.resolve(__dirname, 'dist'), // Modifiez le chemin de sortie pour mettre les fichiers dans le dossier dist
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  plugins: [
    new CopyWebpackPlugin({
      patterns: [
        { from: 'auth_config.json', to: 'auth_config.json' }, // Création de auth_config.json dans le dossier dist
        { from: 'server.js', to: 'server.js' }, // Création de server.js dans le dossier dist
        { from: 'public/js', to: 'js' }, // Copie de ui.js dans le dossier dist
        { from: 'index.html', to: 'index.html' }, // Copie de index.html dans le dossier dist
        { from: 'public/css', to: 'css' }, // Copie du dossier css dans le dossier dist
        { from: 'public/images', to: 'images' }, // Copie du dossier images dans le dossier dist
      ],
    }),
  ],
};