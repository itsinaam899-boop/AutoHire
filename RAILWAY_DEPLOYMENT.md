# Railway Deployment Guide

## Prerequisites
- GitHub account with your repository
- Railway account (free tier available)

## Deployment Steps

### 1. Push to GitHub
```bash
git add .
git commit -m "Add Railway deployment files"
git push origin main
```

### 2. Connect Railway to GitHub
1. Go to [railway.app](https://railway.app)
2. Click **"New Project"** → **"Deploy from GitHub repo"**
3. Select your `job-scraper` repository
4. Railway will auto-detect the Dockerfile

### 3. Configure Environment Variables in Railway
1. Go to your Railway project dashboard
2. Click **"Variables"** tab
3. Add these environment variables:

```
DATABASE_URL=postgresql://user:password@host:port/database
```

**For PostgreSQL Database:**
- Click **"Add Database"** → Select **PostgreSQL**
- Railway will auto-populate `DATABASE_URL`

### 4. Configure Domain & Port
1. In Railway dashboard, go to **"Deployments"**
2. Click your service
3. Go to **"Networking"** tab
4. Railway assigns a public URL automatically
5. Port is set to `8000` in Dockerfile

### 5. Deploy
- Push to GitHub and Railway auto-deploys
- Or manually trigger from Railway dashboard
- Watch deployment logs in real-time

## Environment Variables Needed

| Variable | Example | Required |
|----------|---------|----------|
| `DATABASE_URL` | `postgresql://user:pass@host/db` | ✅ Yes |
| `ENVIRONMENT` | `production` | No |

## Monitor Your Deployment

1. Check logs in Railway dashboard
2. View real-time metrics (CPU, Memory)
3. Restart services if needed

## Endpoints After Deployment

Your API will be available at:
```
https://your-project.railway.app/
```

Available endpoints:
- `POST /jobs/scrape` - Scrape job profiles
- `GET /jobs` - Get all jobs
- `POST /create-tables` - Initialize database

## Troubleshooting

### Build Fails
- Check Playwright browser installation in logs
- Ensure `requirements.txt` has all dependencies

### Database Connection Error
- Verify `DATABASE_URL` is set correctly
- Check PostgreSQL service is running in Railway

### Application Crashes
- View deployment logs for error details
- Check if port `8000` is correctly exposed

## Database Setup

If using Railway PostgreSQL:
1. Railway auto-creates database
2. Set `DATABASE_URL` env variable
3. Your app will create tables on startup
4. Call `/create-tables` endpoint to initialize schema

## Cost Considerations

Railway Free Tier includes:
- 500 hours/month compute
- 5GB PostgreSQL storage
- Pay-as-you-go after free tier

## CI/CD Pipeline

Railway automatically:
- Watches your GitHub repository
- Builds on every push to main branch
- Deploys successfully built images
- Rolls back on deployment failure
