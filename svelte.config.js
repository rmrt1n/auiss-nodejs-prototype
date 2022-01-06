import { mdsvex } from 'mdsvex';
import mdsvexConfig from './mdsvex.config.js';
import adapter from '@sveltejs/adapter-node';
import { optimizeImports } from 'carbon-preprocess-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  extensions: ['.svelte', ...mdsvexConfig.extensions],
  preprocess: [optimizeImports(), mdsvex(mdsvexConfig)],

  kit: {
    adapter: adapter({ out: 'build' }),

    // hydrate the <div id="svelte"> element in src/app.html
    target: '#svelte',
  },
};

export default config;
