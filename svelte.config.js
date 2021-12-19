import adapter from '@sveltejs/adapter-node';
import { optimizeImports } from 'carbon-preprocess-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  preprocess: [optimizeImports()],
  kit: {
    adapter: adapter({ out: 'build' }),

    // hydrate the <div id="svelte"> element in src/app.html
    target: '#svelte',
  },
};

export default config;
