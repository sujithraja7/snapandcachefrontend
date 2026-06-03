# Vercel Deployment Checklist

Use this checklist to ensure your project is properly prepared for Vercel deployment.

## Pre-Deployment Setup

- [ ] **Create Vercel Account**
  - [ ] Sign up at vercel.com
  - [ ] Connect GitHub account
  - [ ] Grant repository access

- [ ] **Reorganize Project Structure**
  - [ ] Run `reorganize-for-vercel.ps1` script OR manually reorganize
  - [ ] Create `api/` folder for backend
  - [ ] Move frontend apps to `apps/` folder
  - [ ] Verify all files are in correct locations

- [ ] **Update Root package.json**
  - [ ] Replace with Vercel-optimized version
  - [ ] Update build scripts
  - [ ] Add workspace configuration
  - [ ] Update dependencies if needed

- [ ] **Create Configuration Files**
  - [ ] ✓ `vercel.json` created
  - [ ] ✓ `VERCEL_DEPLOYMENT_GUIDE.md` created
  - [ ] ✓ `FOLDER_STRUCTURE_MIGRATION.md` created
  - [ ] Create `.env.example` for environment variables
  - [ ] Create `.env.local` for local development

## Code Updates

- [ ] **Backend/API Updates**
  - [ ] Move backend routes to `api/` folder
  - [ ] Update database connection logic
  - [ ] Convert Express routes to serverless functions
  - [ ] Update CORS configuration
  - [ ] Test all API endpoints locally

- [ ] **Import Path Updates**
  - [ ] Update all relative imports
  - [ ] Fix model imports
  - [ ] Fix utility imports
  - [ ] Fix middleware imports
  - [ ] Test imports in all files

- [ ] **Environment Variables**
  - [ ] Add MongoDB URI
  - [ ] Add JWT Secret
  - [ ] Add Cloudinary credentials
  - [ ] Add any other required variables

- [ ] **Dependencies**
  - [ ] Check all `package.json` files
  - [ ] Remove unused dependencies
  - [ ] Ensure all required packages are listed
  - [ ] Run `npm install` in each package directory

## Dashboard (Officer-Dashboard) Updates

- [ ] **Build Configuration**
  - [ ] Verify `vite.config.ts` is correct
  - [ ] Check build output directory (should be `dist/`)
  - [ ] Test build: `npm run build`
  - [ ] Verify `dist/` folder is created

- [ ] **API Connection**
  - [ ] Update API base URL to `/api`
  - [ ] Update all API calls to use correct endpoints
  - [ ] Test API calls in development

- [ ] **Environment Setup**
  - [ ] Create `.env.local` for development
  - [ ] Create `.env.production` for production
  - [ ] Verify environment variables are loaded correctly

## Website Updates

- [ ] **Build Configuration**
  - [ ] Verify build script in `package.json`
  - [ ] Check output directory
  - [ ] Test build locally
  - [ ] Verify static assets are referenced correctly

- [ ] **Links and Routes**
  - [ ] Update internal links
  - [ ] Update API endpoints
  - [ ] Test navigation locally

## Local Testing

- [ ] **Vercel CLI Setup**
  - [ ] Install: `npm install -g vercel`
  - [ ] Login: `vercel login`
  - [ ] Link project: `vercel link`

- [ ] **Local Development**
  - [ ] Test with `vercel dev`
  - [ ] Check API routes work at `/api/*`
  - [ ] Check frontend loads correctly
  - [ ] Test API calls from frontend
  - [ ] Check environment variables load

- [ ] **Build Testing**
  - [ ] Run `npm run build`
  - [ ] Verify all packages build successfully
  - [ ] Check build output sizes
  - [ ] Test built artifacts locally

## Git & Repository

- [ ] **Git Setup**
  - [ ] Commit all changes
  - [ ] Push to main branch
  - [ ] Create `.gitignore` if needed
  - [ ] Exclude `node_modules`, `dist`, `.env.local`

- [ ] **Environment Files**
  - [ ] `.env.example` included (but NOT `.env.local` or `.env`)
  - [ ] `.gitignore` updated to exclude secret files
  - [ ] No hardcoded secrets in code

## Vercel Dashboard Configuration

- [ ] **Project Settings**
  - [ ] Link GitHub repository
  - [ ] Select root directory (project root)
  - [ ] Set Node.js version (18.x or 20.x)
  - [ ] Verify framework detection (Other)

- [ ] **Environment Variables**
  - [ ] Add `MONGODB_URI`
  - [ ] Add `JWT_SECRET`
  - [ ] Add `CLOUDINARY_NAME`
  - [ ] Add `CLOUDINARY_API_KEY`
  - [ ] Add `CLOUDINARY_API_SECRET`
  - [ ] Add `NODE_ENV=production`

- [ ] **Build & Deployment**
  - [ ] Set build command: `npm run build`
  - [ ] Set output directory: Empty or `.vercel/output`
  - [ ] Verify `vercel.json` settings
  - [ ] Check all routes are configured

- [ ] **Domains**
  - [ ] Add custom domain (if applicable)
  - [ ] Configure DNS records
  - [ ] Enable HTTPS (auto-enabled by default)

## Database Setup

- [ ] **MongoDB Atlas**
  - [ ] Create MongoDB cluster (if not done)
  - [ ] Create database user
  - [ ] Get connection string
  - [ ] Whitelist Vercel IP addresses:
    - [ ] 76.75.126.0/24
    - [ ] 145.40.68.0/24
    - [ ] 2603:1030:b04::/48

- [ ] **Connection Testing**
  - [ ] Test connection locally with `.env.local`
  - [ ] Verify connection from Vercel

## File Upload & Cloud Services

- [ ] **Cloudinary**
  - [ ] Create Cloudinary account (if not done)
  - [ ] Get API credentials
  - [ ] Add credentials to Vercel environment
  - [ ] Test file uploads in development

- [ ] **Other Services**
  - [ ] Configure any other external services
  - [ ] Add credentials to Vercel
  - [ ] Test integrations

## Security

- [ ] **Secrets**
  - [ ] No secrets in code
  - [ ] No secrets in GitHub
  - [ ] All secrets in Vercel environment variables
  - [ ] Rotate JWT secret

- [ ] **CORS**
  - [ ] Configure CORS headers in API
  - [ ] Whitelist correct domains
  - [ ] Test CORS in development

- [ ] **Rate Limiting**
  - [ ] Implement rate limiting if needed
  - [ ] Test rate limiting works

## Deployment

- [ ] **First Deployment**
  - [ ] Push code to GitHub main branch
  - [ ] Monitor Vercel build in dashboard
  - [ ] Check build logs for errors
  - [ ] Verify deployment is successful

- [ ] **Post-Deployment Testing**
  - [ ] Visit production URL
  - [ ] Check all pages load
  - [ ] Test API endpoints
  - [ ] Test file uploads
  - [ ] Check database connectivity
  - [ ] Monitor Vercel analytics

- [ ] **Rollback Plan**
  - [ ] Know how to rollback in Vercel
  - [ ] Have previous working deployment ready
  - [ ] Document any critical fixes needed

## Monitoring & Maintenance

- [ ] **Analytics**
  - [ ] Monitor Vercel analytics
  - [ ] Check error rates
  - [ ] Monitor performance metrics

- [ ] **Logs**
  - [ ] Check deployment logs regularly
  - [ ] Monitor API error logs
  - [ ] Set up alerting if available

- [ ] **Updates**
  - [ ] Plan dependency updates
  - [ ] Test updates in development first
  - [ ] Document any breaking changes

## Troubleshooting

Common issues and solutions:

### Build Fails
- [ ] Check build logs in Vercel dashboard
- [ ] Verify all dependencies are installed
- [ ] Ensure build script is correct
- [ ] Check for syntax errors

### API Not Working
- [ ] Verify route configuration in `vercel.json`
- [ ] Check MongoDB connection
- [ ] Verify environment variables are set
- [ ] Check API function syntax

### Frontend Not Loading
- [ ] Verify build output directory
- [ ] Check dist folder is created
- [ ] Clear browser cache
- [ ] Check console for errors

### Database Connection Issues
- [ ] Verify MongoDB connection string
- [ ] Check IP whitelist in MongoDB Atlas
- [ ] Verify credentials are correct
- [ ] Test connection with MongoDB shell

### Timeouts
- [ ] Optimize API functions
- [ ] Check for long-running operations
- [ ] Consider upgrading Vercel plan
- [ ] Implement async processing

## Final Checklist

- [ ] All code committed and pushed
- [ ] Environment variables set in Vercel
- [ ] Build succeeds without errors
- [ ] All API endpoints working
- [ ] Frontend loads and functions correctly
- [ ] Database connection working
- [ ] File uploads working (if applicable)
- [ ] All external services integrated
- [ ] Monitoring set up
- [ ] Team has access to Vercel project
- [ ] Documentation updated

---

## Notes Section

Use this space to track any custom configurations or special notes:

```
[Your notes here]


```

---

**Last Updated:** 2026-06-03
**Project:** SnapNEarn
**Status:** Ready for Deployment

