import { defineConfig } from 'vite';

export default defineConfig({
  // Root directory is the website folder itself
  root: '.',
  
  build: {
    // Output to dist/ folder
    outDir: 'dist',
    
    // Clean the output directory before build
    emptyOutDir: true,
    
    // Configure asset handling
    assetsDir: 'assets',
    
    // Inline small assets as base64
    assetsInlineLimit: 4096,
    
    rollupOptions: {
      input: {
        main: './index.html'
      }
    }
  },

  server: {
    port: 3000,
    open: true
  },

  preview: {
    port: 4173
  }
});
