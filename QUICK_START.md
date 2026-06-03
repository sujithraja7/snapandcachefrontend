# Quick Start: Vercel Deployment Guide

Your project is now configured for Vercel deployment! Here's how to proceed.

## 📁 Your New Project Structure

```
SnapNEarn-App-main/
│
├── 📂 api/                          ← Backend Serverless Functions
│   ├── auth.js                      (Authentication routes)
│   ├── reports.js                   (Report management)
│   ├── users.js                     (User management)
│   ├── violations.js                (Violation tracking)
│   ├── payments.js                  (Payment processing)
│   ├── police.js                    (Police officer endpoints)
│   ├── config.js                    (Database connection)
│   ├── middleware/                  (Auth, validation, etc.)
│   ├── models/                      (MongoDB schemas)
│   ├── utils/                       (Helper functions)
│   └── package.json
│
├── 📂 apps/                         ← Frontend Applications
│   ├── 📂 dashboard/                (Officer Dashboard - React + TypeScript + Vite)
│   │   ├── src/
│   │   ├── dist/                    (Build output)
│   │   ├── package.json
│   │   └── vite.config.ts
│   │
│   ├── 📂 website/                  (Landing Website)
│   │   ├── src/
│   │   ├── dist/                    (Build output)
│   │   ├── index.html
│   │   └── package.json
│   │
│   └── 📂 mobile/                   (Mobile App - React Native, local dev only)
│       ├── src/
│       ├── package.json
│       └── app.config.js
│
├── 📂 shared/                       ← Shared Code & Types (optional)
│   ├── types/
│   ├── constants/
│   └── utils/
│
├── 📄 vercel.json                   ← Vercel Configuration ✓
├── 📄 package.json                  ← Root Monorepo Config
├── 📄 .env.example                  ← Environment Variables Template
├── 📄 .gitignore                    ← Git Ignore Rules
│
└── 📚 Documentation Files:
    ├── VERCEL_DEPLOYMENT_GUIDE.md                  (Full guide)
    ├── FOLDER_STRUCTURE_MIGRATION.md               (Migration steps)
    ├── VERCEL_DEPLOYMENT_CHECKLIST.md              (Pre-deployment checks)
    ├── reorganize-for-vercel.ps1                   (Reorganization script)
    └── QUICK_START.md                              (This file)
```

## 🚀 Getting Started: 3 Steps

### Step 1: Reorganize Your Folder Structure (if not done)

**Option A: Automatic (Recommended)**
```powershell
# Run the reorganization script
.\reorganize-for-vercel.ps1
```

**Option B: Manual**
Follow the detailed instructions in [FOLDER_STRUCTURE_MIGRATION.md](FOLDER_STRUCTURE_MIGRATION.md)

### Step 2: Set Up Local Environment

```bash
# Create local environment file
copy .env.example .env.local

# Edit .env.local with your credentials
# MONGODB_URI=your_connection_string
# JWT_SECRET=your_secret_key
# CLOUDINARY_NAME=your_cloudinary_name
# CLOUDINARY_API_KEY=your_api_key
# CLOUDINARY_API_SECRET=your_api_secret
```

### Step 3: Test Locally with Vercel

```bash
# Install Vercel CLI globally
npm install -g vercel

# Install all dependencies
npm install

# Test locally
vercel dev
```

Your app should now be running at `http://localhost:3000`

## 📋 Before Deploying to Vercel

Complete the [VERCEL_DEPLOYMENT_CHECKLIST.md](VERCEL_DEPLOYMENT_CHECKLIST.md)

Key items:
- ✓ Vercel account created and linked to GitHub
- ✓ All environment variables prepared
- ✓ Code builds without errors locally
- ✓ All API endpoints tested
- ✓ MongoDB connection working

## 🌐 Deploy to Vercel

### Option 1: Via GitHub (Recommended)

1. Push your code to GitHub:
   ```bash
   git add .
   git commit -m "chore: prepare for Vercel deployment"
   git push origin main
   ```

2. Go to [vercel.com](https://vercel.com)
3. Click "Add New..." → "Project"
4. Import your GitHub repository
5. Configure project settings:
   - Framework: Other
   - Root directory: ./
   - Build command: `npm run build`

6. Add environment variables in Vercel Settings:
   - `MONGODB_URI`
   - `JWT_SECRET`
   - `CLOUDINARY_NAME`
   - `CLOUDINARY_API_KEY`
   - `CLOUDINARY_API_SECRET`
   - `NODE_ENV=production`

7. Click "Deploy"

### Option 2: Via Vercel CLI

```bash
# Login to Vercel
vercel login

# Deploy to production
vercel --prod
```

## 📊 Project Structure Explanation

| Folder | Purpose | Deployment |
|--------|---------|-----------|
| `api/` | Backend routes & serverless functions | Vercel Functions |
| `apps/dashboard/` | Officer dashboard application | Vercel Static |
| `apps/website/` | Landing page website | Vercel Static |
| `apps/mobile/` | Mobile app (Expo) | Not deployed (local/expo) |
| `shared/` | Shared code between apps | Referenced by packages |

## 🔌 API Endpoints

After deployment, your API will be available at:
```
https://your-domain.vercel.app/api/*
```

Examples:
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `GET /api/reports` - Get all reports
- `POST /api/reports` - Create new report
- `GET /api/users/:id` - Get user details
- `GET /api/violations` - Get violations

## 🔧 Vercel Configuration Details

Your `vercel.json` handles:
- ✓ API routing to `/api/*`
- ✓ Frontend serving from `/`
- ✓ CORS configuration
- ✓ Environment variables
- ✓ Serverless function configuration

## 🐛 Troubleshooting

### Build fails after deployment
```
→ Check Vercel build logs
→ Ensure all dependencies are in package.json
→ Verify build script is correct
```

### API endpoints return 404
```
→ Verify vercel.json routes are configured
→ Check function files exist in api/
→ Ensure function exports are correct
```

### Frontend not loading
```
→ Check build output exists in dist/
→ Verify vite config is correct
→ Clear browser cache and reload
```

### Environment variables not set
```
→ Add variables in Vercel Project Settings
→ Restart build after adding variables
→ Verify variable names match code
```

See [VERCEL_DEPLOYMENT_GUIDE.md](VERCEL_DEPLOYMENT_GUIDE.md) for detailed troubleshooting.

## 📚 Documentation Files

| File | Contents |
|------|----------|
| [VERCEL_DEPLOYMENT_GUIDE.md](VERCEL_DEPLOYMENT_GUIDE.md) | Comprehensive deployment guide |
| [FOLDER_STRUCTURE_MIGRATION.md](FOLDER_STRUCTURE_MIGRATION.md) | Detailed migration instructions |
| [VERCEL_DEPLOYMENT_CHECKLIST.md](VERCEL_DEPLOYMENT_CHECKLIST.md) | Pre-deployment checklist |
| [SAMPLE_API_STRUCTURE.js](SAMPLE_API_STRUCTURE.js) | Example API function structure |
| [vercel.json](vercel.json) | Vercel configuration file |

## 🎯 Next Steps

1. **Organize your folder structure**
   - Run `reorganize-for-vercel.ps1` or reorganize manually

2. **Update your code**
   - Convert Express routes to serverless functions
   - Update import paths
   - Update API URLs

3. **Test locally**
   - Run `vercel dev`
   - Test all endpoints
   - Check frontend functionality

4. **Deploy**
   - Push to GitHub
   - Connect to Vercel
   - Set environment variables
   - Deploy!

5. **Monitor**
   - Watch Vercel analytics
   - Check error logs
   - Monitor performance

## 💡 Pro Tips

- **Cold Starts**: First request may be slower (~1-2s). Keep functions lightweight.
- **Timeouts**: Default timeout is 30 seconds. Optimize code or upgrade plan.
- **Database**: Use connection pooling for MongoDB to avoid connection exhaustion.
- **File Size**: Keep individual functions under 1MB for best performance.
- **Logs**: Monitor Vercel logs to catch errors early.

## 🆘 Need Help?

1. Check the [VERCEL_DEPLOYMENT_GUIDE.md](VERCEL_DEPLOYMENT_GUIDE.md)
2. Review [FOLDER_STRUCTURE_MIGRATION.md](FOLDER_STRUCTURE_MIGRATION.md)
3. Complete the [VERCEL_DEPLOYMENT_CHECKLIST.md](VERCEL_DEPLOYMENT_CHECKLIST.md)
4. Check Vercel documentation: https://vercel.com/docs
5. Check sample function structure in [SAMPLE_API_STRUCTURE.js](SAMPLE_API_STRUCTURE.js)

---

## Summary

✅ **Vercel Configuration Files Created:**
- `vercel.json` - Deployment configuration
- `package.json.vercel` - Monorepo root config (rename to package.json)
- `.env.example` - Environment variables template

✅ **Documentation Created:**
- `VERCEL_DEPLOYMENT_GUIDE.md` - Full deployment guide
- `FOLDER_STRUCTURE_MIGRATION.md` - Detailed migration steps
- `VERCEL_DEPLOYMENT_CHECKLIST.md` - Pre-deployment checklist
- `reorganize-for-vercel.ps1` - Automatic folder reorganization script
- `QUICK_START.md` - This file

**Your project is ready for Vercel deployment!** 🎉

Start with Step 1 in "Getting Started: 3 Steps" above.

