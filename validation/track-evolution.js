#!/usr/bin/env node

/**
 * Evolution Tracking Tool
 * Tracks configuration evolution and captures learning
 * Updates evolution log with usage patterns and changes
 */

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

class EvolutionTracker {
    constructor() {
        this.configPath = '/home/coder/config';
        this.evolutionLogPath = path.join(this.configPath, 'evolution.log.json');
        this.evolutionLog = null;
    }

    async loadEvolutionLog() {
        try {
            const logContent = fs.readFileSync(this.evolutionLogPath, 'utf8');
            this.evolutionLog = JSON.parse(logContent);
            return true;
        } catch (error) {
            console.log('📝 Creating new evolution log...');
            this.evolutionLog = this.createNewEvolutionLog();
            return false;
        }
    }

    createNewEvolutionLog() {
        return {
            meta: {
                created: new Date().toISOString(),
                purpose: "Track FCM configuration evolution and learning",
                version_format: "semantic versioning (major.minor.patch)"
            },
            current_state: {
                version: "0.3.0",
                timestamp: new Date().toISOString(),
                fcm_compliance: true,
                validation_status: "pending",
                active_mounts: [],
                capabilities: []
            },
            evolution_history: [],
            learning_insights: [],
            evolution_patterns: [],
            predicted_evolution: [],
            evolution_metrics: {}
        };
    }

    async trackStartup() {
        console.log('🚀 Tracking startup event...');
        
        await this.loadEvolutionLog();
        
        // Update current state
        this.evolutionLog.current_state.timestamp = new Date().toISOString();
        this.evolutionLog.current_state.validation_status = "running";
        
        // Detect environment and capabilities
        await this.detectEnvironment();
        
        // Check for configuration changes
        await this.detectConfigurationChanges();
        
        // Save updated log
        await this.saveEvolutionLog();
        
        console.log('✅ Startup tracking complete');
    }

    async detectEnvironment() {
        const capabilities = [];
        const activeMounts = [];
        
        // Check for mounted directories
        const mountPoints = [
            { path: '/home/coder/models', name: 'models' },
            { path: '/home/coder/config', name: 'config' },
            { path: '/home/coder/validation', name: 'validation' },
            { path: '/home/coder/project', name: 'repository' }
        ];
        
        mountPoints.forEach(mount => {
            if (fs.existsSync(mount.path)) {
                activeMounts.push(mount.name);
                
                // Determine capabilities based on mounts
                switch (mount.name) {
                    case 'models':
                        capabilities.push('formal_modeling');
                        break;
                    case 'validation':
                        capabilities.push('fcm_validation');
                        break;
                    case 'config':
                        capabilities.push('configuration_management');
                        break;
                    case 'repository':
                        capabilities.push('repository_analysis');
                        break;
                }
            }
        });
        
        // Check for specific tools
        if (fs.existsSync('/home/coder/validation/validate-fcm.js')) {
            capabilities.push('structural_validation');
        }
        
        if (fs.existsSync('/home/coder/models/fcm.sidecar.md')) {
            capabilities.push('pattern_teaching');
        }
        
        this.evolutionLog.current_state.active_mounts = activeMounts;
        this.evolutionLog.current_state.capabilities = capabilities;
    }

    async detectConfigurationChanges() {
        // Calculate hash of current configuration
        const configFiles = [
            'claude.config.fcm.json',
            'validation.rules.json'
        ];
        
        let combinedContent = '';
        configFiles.forEach(file => {
            const filePath = path.join(this.configPath, file);
            if (fs.existsSync(filePath)) {
                combinedContent += fs.readFileSync(filePath, 'utf8');
            }
        });
        
        const currentHash = crypto.createHash('sha256').update(combinedContent).digest('hex').substring(0, 16);
        
        // Check if hash has changed since last evolution
        const lastEvolution = this.evolutionLog.evolution_history[this.evolutionLog.evolution_history.length - 1];
        
        if (lastEvolution && lastEvolution.config_hash && lastEvolution.config_hash !== currentHash) {
            console.log('🔄 Configuration changes detected');
            await this.recordEvolutionEvent(currentHash);
        } else if (!lastEvolution) {
            console.log('📋 Initial configuration tracking');
            await this.recordEvolutionEvent(currentHash);
        }
    }

    async recordEvolutionEvent(configHash) {
        // Increment version (patch level for automatic detection)
        const currentVersion = this.evolutionLog.current_state.version;
        const [major, minor, patch] = currentVersion.split('.').map(Number);
        const newVersion = `${major}.${minor}.${patch + 1}`;
        
        const evolutionEvent = {
            version: newVersion,
            timestamp: new Date().toISOString(),
            description: "Automatic configuration evolution detected",
            config_hash: configHash,
            changes: await this.detectSpecificChanges(),
            trigger: "configuration_modification",
            learning: await this.captureCurrentLearning(),
            fcm_compliance: true,
            auto_detected: true
        };
        
        this.evolutionLog.evolution_history.push(evolutionEvent);
        this.evolutionLog.current_state.version = newVersion;
        
        console.log(`📈 Recorded evolution event: ${newVersion}`);
    }

    async detectSpecificChanges() {
        // Simple change detection - in practice would be more sophisticated
        const changes = [];
        
        // Check if new files exist
        const expectedFiles = [
            { path: '/home/coder/models/fcm.sidecar.md', change: 'added formal sidecar model' },
            { path: '/home/coder/models/fcm.docker-bridge.md', change: 'added docker bridge model' },
            { path: '/home/coder/models/fcm.config.md', change: 'added configuration model' },
            { path: '/home/coder/validation/validate-fcm.js', change: 'added FCM validation tool' }
        ];
        
        expectedFiles.forEach(file => {
            if (fs.existsSync(file.path)) {
                changes.push(file.change);
            }
        });
        
        return changes.length > 0 ? changes : ['configuration refinement'];
    }

    async captureCurrentLearning() {
        // Capture learning based on environment state
        const insights = [];
        
        if (this.evolutionLog.current_state.active_mounts.includes('models')) {
            insights.push('formal models enable structural validation');
        }
        
        if (this.evolutionLog.current_state.active_mounts.includes('validation')) {
            insights.push('validation tools prevent FCM compliance violations');
        }
        
        if (this.evolutionLog.current_state.capabilities.includes('pattern_teaching')) {
            insights.push('formal patterns enable teaching through structure');
        }
        
        return insights.join('; ');
    }

    async trackUsagePattern(operation, details = {}) {
        console.log(`📊 Tracking usage: ${operation}`);
        
        // Update evolution metrics
        if (!this.evolutionLog.evolution_metrics.usage_patterns) {
            this.evolutionLog.evolution_metrics.usage_patterns = {};
        }
        
        const patterns = this.evolutionLog.evolution_metrics.usage_patterns;
        if (!patterns[operation]) {
            patterns[operation] = { count: 0, last_used: null, details: [] };
        }
        
        patterns[operation].count++;
        patterns[operation].last_used = new Date().toISOString();
        
        if (details && Object.keys(details).length > 0) {
            patterns[operation].details.push({
                timestamp: new Date().toISOString(),
                ...details
            });
            
            // Keep only last 10 details to prevent unlimited growth
            if (patterns[operation].details.length > 10) {
                patterns[operation].details = patterns[operation].details.slice(-10);
            }
        }
        
        await this.saveEvolutionLog();
    }

    async analyzeEvolutionTrends() {
        console.log('📈 Analyzing evolution trends...');
        
        const history = this.evolutionLog.evolution_history;
        if (history.length < 2) {
            console.log('Not enough evolution history for trend analysis');
            return;
        }
        
        // Analyze evolution frequency
        const evolutionTimes = history.map(h => new Date(h.timestamp));
        const intervals = [];
        
        for (let i = 1; i < evolutionTimes.length; i++) {
            const interval = evolutionTimes[i] - evolutionTimes[i-1];
            intervals.push(interval);
        }
        
        const avgInterval = intervals.reduce((a, b) => a + b, 0) / intervals.length;
        const avgDays = avgInterval / (1000 * 60 * 60 * 24);
        
        // Update metrics
        this.evolutionLog.evolution_metrics.avg_evolution_interval_days = avgDays;
        this.evolutionLog.evolution_metrics.total_evolutions = history.length;
        this.evolutionLog.evolution_metrics.evolution_velocity = history.length / 
            ((Date.now() - new Date(history[0].timestamp)) / (1000 * 60 * 60 * 24));
        
        console.log(`📊 Evolution metrics updated: ${history.length} total evolutions, ${avgDays.toFixed(1)} avg days between`);
    }

    async predictNextEvolution() {
        const patterns = this.evolutionLog.evolution_metrics.usage_patterns || {};
        const predictions = [];
        
        // Simple prediction based on usage patterns
        Object.entries(patterns).forEach(([operation, data]) => {
            if (data.count > 5) {
                predictions.push({
                    trigger: `frequent_${operation}`,
                    likelihood: 'high',
                    predicted_changes: [`optimization for ${operation}`],
                    timeline: 'short term'
                });
            }
        });
        
        // Update predicted evolution
        this.evolutionLog.predicted_evolution = predictions;
    }

    async captureShutdownLearning() {
        console.log('🛑 Capturing shutdown learning...');
        
        // Analyze session patterns
        await this.analyzeEvolutionTrends();
        await this.predictNextEvolution();
        
        // Update final state
        this.evolutionLog.current_state.validation_status = 'completed';
        this.evolutionLog.current_state.last_shutdown = new Date().toISOString();
        
        await this.saveEvolutionLog();
        
        console.log('✅ Shutdown learning captured');
    }

    async saveEvolutionLog() {
        try {
            const logContent = JSON.stringify(this.evolutionLog, null, 2);
            fs.writeFileSync(this.evolutionLogPath, logContent);
            return true;
        } catch (error) {
            console.error('❌ Failed to save evolution log:', error.message);
            return false;
        }
    }

    async generateEvolutionReport() {
        console.log('📋 Generating evolution report...');
        
        const report = {
            summary: {
                current_version: this.evolutionLog.current_state.version,
                total_evolutions: this.evolutionLog.evolution_history.length,
                fcm_compliance: this.evolutionLog.current_state.fcm_compliance,
                active_capabilities: this.evolutionLog.current_state.capabilities.length
            },
            recent_evolution: this.evolutionLog.evolution_history.slice(-3),
            learning_insights: this.evolutionLog.learning_insights.slice(-5),
            usage_summary: this.evolutionLog.evolution_metrics.usage_patterns,
            predictions: this.evolutionLog.predicted_evolution
        };
        
        const reportPath = path.join(this.configPath, 'evolution.report.json');
        fs.writeFileSync(reportPath, JSON.stringify(report, null, 2));
        
        console.log('✅ Evolution report generated');
        return report;
    }
}

// Main execution functions
async function trackStartup() {
    const tracker = new EvolutionTracker();
    await tracker.trackStartup();
}

async function trackUsage(operation, details = {}) {
    const tracker = new EvolutionTracker();
    await tracker.loadEvolutionLog();
    await tracker.trackUsagePattern(operation, details);
}

async function trackShutdown() {
    const tracker = new EvolutionTracker();
    await tracker.loadEvolutionLog();
    await tracker.captureShutdownLearning();
}

async function generateReport() {
    const tracker = new EvolutionTracker();
    await tracker.loadEvolutionLog();
    return await tracker.generateEvolutionReport();
}

// Command line interface
async function main() {
    const command = process.argv[2] || 'startup';
    const details = process.argv[3] ? JSON.parse(process.argv[3]) : {};
    
    switch (command) {
        case 'startup':
            await trackStartup();
            break;
        case 'usage':
            const operation = process.argv[3] || 'unknown';
            await trackUsage(operation, details);
            break;
        case 'shutdown':
            await trackShutdown();
            break;
        case 'report':
            await generateReport();
            break;
        default:
            console.log('Usage: track-evolution.js [startup|usage|shutdown|report] [operation] [details]');
            process.exit(1);
    }
}

// Run if called directly
if (require.main === module) {
    main().catch(error => {
        console.error('❌ Evolution tracking failed:', error.message);
        process.exit(1);
    });
}

module.exports = { EvolutionTracker, trackStartup, trackUsage, trackShutdown, generateReport };