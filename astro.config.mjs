// @ts-check
import svelte from "@astrojs/svelte";
import tailwindcss from "@tailwindcss/vite";
import compressor from "astro-compressor";
import { defineConfig } from "astro/config";

// https://astro.build/config
export default defineConfig({
  integrations: [svelte(), compressor()],

  vite: {
    plugins: [tailwindcss()],
  },
});
