#!/usr/bin/env node

/**
 * Usage Report Generator
 * Extracts usage patterns from evolution log and generates markdown report
 */

const fs = require('fs');
const path = require('path');

function generateUsageReport() {
    try {
        // Read evolution log
        const evolutionPath = '/home/coder/config/evolution.log.json';
        const evolutionContent = fs.readFileSync(evolutionPath, 'utf8');
        const evolutionLog = JSON.parse(evolutionContent);
        
        // Extract usage patterns
        const usagePatterns = evolutionLog.evolution_metrics?.usage_patterns || {};
        
        // Generate report
        const currentDate = new Date().toISOString().split('T')[0];
        const title = 'Claude Code Docker Sidecar - Usage Pattern Report';
        
        let report = `# ${title}\n\n`;
        report += `**Generated:** ${currentDate}\n\n`;
        
        // Summary
        const totalOperations = Object.values(usagePatterns).reduce((sum, count) => sum + (count || 0), 0);
        report += `## Summary\n\n`;
        report += `Total operations tracked: ${totalOperations}\n\n`;
        
        // Operations list
        report += `## Operations\n\n`;
        Object.entries(usagePatterns).forEach(([operation, count]) => {
            report += `- **${operation}**: ${count || 0}\n`;
        });
        
        // Write report
        const reportPath = '/home/coder/config/usage-report.md';
        fs.writeFileSync(reportPath, report);
        
        console.log('Usage report generated successfully');
        
    } catch (error) {
        console.error('Error generating usage report:', error.message);
        process.exit(1);
    }
}

// Run if called directly
if (require.main === module) {
    generateUsageReport();
}

module.exports = generateUsageReport;