# Vercel Deployment Guide

This project is configured as a monorepo optimized for Vercel deployment.

## Project Structure

```
SnapNEarn-App-main/
├── api/                      # Backend serverless functions (Node.js)
│   ├── auth.js
│   ├── reports.js
│   ├── users.js
│   ├── violations.js
│   ├── payments.js
│   ├── police.js
│   └── middleware/           # Shared middleware
│
├── apps/
│   ├── dashboard/            # Officer Dashboard (React + TypeScript)
│   │   ├── src/
│   │   ├── dist/            # Build output
│   │   ├── package.json
│   │   └── vite.config.ts
│   │
│   ├── website/              # Landing Website (HTML/CSS/JS)
│   │   ├── index.html
│   │   ├── dist/            # Build output
│   │   ├── package.json
│   │   └── script.js
│   │
│   └── mobile/               # Mobile App (React Native - local development)
│       ├── src/
│       ├── package.json
│       └── app.config.js
│
├── shared/                   # Shared utilities, types, and helpers
│   ├── utils/
│   ├── types/
│   └── constants/
│
├── package.json             # Root monorepo configuration
├── vercel.json             # Vercel deployment configuration
├── tsconfig.json           # TypeScript configuration (if needed)
└── .env.example            # Environment variables template
```

## Deployment Instructions

### 1. Environment Variables

Add these environment variables to Vercel project settings:

```
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret_key
CLOUDINARY_NAME=your_cloudinary_name
CLOUDINARY_API_KEY=your_cloudinary_api_key
CLOUDINARY_API_SECRET=your_cloudinary_api_secret
NODE_ENV=production
```

### 2. Build Configuration

The `vercel.json` is configured to:
- Build the dashboard (React app) as static files
- Deploy backend routes as serverless functions under `/api`
- Route all API calls to the backend
- Serve the dashboard as the main app

### 3. Local Testing

Before deployment, test locally:

```bash
# Install dependencies for all apps
npm install

# Build all apps
npm run build

# Test with Vercel locally
vercel dev
```

### 4. Deploy to Vercel

```bash
# Connect your Git repository to Vercel
# Vercel will automatically detect package.json and deploy

# Or use Vercel CLI:
vercel
```

## API Routes

All backend routes are available at `/api/*`:

- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `GET /api/reports` - Get reports
- `POST /api/reports` - Create report
- `GET /api/users/:id` - Get user
- `PUT /api/users/:id` - Update user
- `GET /api/violations` - Get violations
- `POST /api/violations` - Create violation
- `GET /api/payments` - Get payments
- `POST /api/payments` - Process payment
- `GET /api/police/:id` - Get police officer
- `PUT /api/police/:id` - Update police officer

## Frontend Routes

The Officer Dashboard will be served at `/` and handles all SPA routes.

## Database

MongoDB connection is established on backend startup using `MONGODB_URI` environment variable.

## Important Notes

1. **Mobile App**: The mobile app should be developed locally and tested with Expo. It's not deployed to Vercel - deploy it separately to Expo, TestFlight, or Google Play Store.

2. **Serverless Timeout**: Default timeout is 30 seconds. For longer operations, upgrade Vercel plan.

3. **Database**: Make sure MongoDB is accessible from Vercel (whitelist Vercel IPs in MongoDB Atlas).

4. **File Uploads**: For file uploads, continue using Cloudinary as configured.

5. **CORS**: Update CORS configuration in backend if deploying frontend and backend separately.

## Troubleshooting

### Build fails
- Check all dependencies are listed in respective `package.json` files
- Ensure environment variables are set in Vercel dashboard
- Check build logs in Vercel console

### API routes not working
- Verify `/api/*` routes are correctly defined in `vercel.json`
- Check backend dependencies and imports
- Ensure MongoDB connection string is correct

### Frontend not loading
- Clear browser cache
- Check that dashboard build output is in `apps/dashboard/dist`
- Verify vite config for correct build output

## Next Steps

1. Move backend logic from `backend/` to `api/` directory (optional but recommended)
2. Update all import paths accordingly
3. Deploy to Vercel
4. Monitor logs in Vercel dashboard
