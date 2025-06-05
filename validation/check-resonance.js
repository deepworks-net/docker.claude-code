#!/usr/bin/env node

/**
 * Resonance Checking Tool
 * Validates that system components maintain resonance alignment
 * Ensures sidecar pattern preserves FCM geometric relationships
 */

const fs = require('fs');
const path = require('path');

class ResonanceChecker {
    constructor() {
        this.configPath = '/home/coder/config';
        this.modelsPath = '/home/coder/models';
        this.results = {
            resonance_score: 0,
            alignment_issues: [],
            geometric_violations: [],
            recommendations: []
        };
    }

    async checkSystemResonance() {
        console.log('🔄 Checking system resonance alignment...');
        
        // Load FCM configuration
        const config = await this.loadConfiguration();
        if (!config) return false;
        
        // Perform resonance checks
        await this.checkStructuralResonance(config);
        await this.checkGeometricAlignment(config);
        await this.checkConceptualCoherence(config);
        await this.checkEvolutionaryResonance(config);
        
        // Calculate overall resonance score
        this.calculateResonanceScore();
        
        // Generate recommendations
        this.generateRecommendations();
        
        return this.reportResults();
    }

    async loadConfiguration() {
        try {
            const configPath = path.join(this.configPath, 'claude.config.fcm.json');
            const configContent = fs.readFileSync(configPath, 'utf8');
            return JSON.parse(configContent);
        } catch (error) {
            this.results.alignment_issues.push({
                type: 'configuration_load_failure',
                message: 'Cannot load FCM configuration',
                impact: 'critical',
                fix: 'Ensure claude.config.fcm.json exists and is valid JSON'
            });
            return null;
        }
    }

    async checkStructuralResonance(config) {
        console.log('🏗️  Checking structural resonance...');
        
        // Check axiom-concept alignment
        const axioms = config.axioms || {};
        const atomicConcepts = config.atomic_concepts || {};
        
        Object.entries(atomicConcepts).forEach(([conceptName, conceptDef]) => {
            if (conceptDef.requires) {
                conceptDef.requires.forEach(requirement => {
                    if (!axioms[requirement] && !atomicConcepts[requirement]) {
                        this.results.alignment_issues.push({
                            type: 'broken_conceptual_chain',
                            concept: conceptName,
                            missing_requirement: requirement,
                            message: `Concept '${conceptName}' requires '${requirement}' but it's not defined`,
                            impact: 'medium',
                            fix: `Define '${requirement}' in axioms or atomic concepts`
                        });
                    }
                });
            }
        });
        
        // Check for resonance keywords in definitions
        const resonanceKeywords = ['beside', 'lateral', 'autonomous', 'boundary', 'bridge'];
        let resonanceKeywordCount = 0;
        
        Object.values(atomicConcepts).forEach(conceptDef => {
            if (conceptDef.definition) {
                resonanceKeywords.forEach(keyword => {
                    if (conceptDef.definition.includes(keyword)) {
                        resonanceKeywordCount++;
                    }
                });
            }
        });
        
        if (resonanceKeywordCount < 3) {
            this.results.alignment_issues.push({
                type: 'low_resonance_vocabulary',
                message: 'Configuration lacks sufficient resonance vocabulary',
                impact: 'low',
                fix: 'Include more resonance-aligned terms (beside, lateral, autonomous, etc.)'
            });
        }
    }

    async checkGeometricAlignment(config) {
        console.log('📐 Checking geometric alignment...');
        
        const sidecarConfig = config.sidecar_configuration;
        if (!sidecarConfig) {
            this.results.geometric_violations.push({
                type: 'missing_sidecar_geometry',
                message: 'No sidecar configuration found',
                impact: 'high',
                fix: 'Add sidecar_configuration section defining geometric relationships'
            });
            return;
        }
        
        // Check for lateral relationship indicators
        const identity = sidecarConfig.identity || {};
        if (identity.relationship && !identity.relationship.includes('beside')) {
            this.results.geometric_violations.push({
                type: 'non_lateral_relationship',
                relationship: identity.relationship,
                message: 'Sidecar relationship is not explicitly lateral',
                impact: 'medium',
                fix: 'Ensure relationship explicitly states "beside" positioning'
            });
        }
        
        // Check boundary definitions
        const boundaries = sidecarConfig.boundaries || {};
        const requiredBoundaries = ['container_isolation', 'volume_mounts', 'network_access'];
        
        requiredBoundaries.forEach(boundary => {
            if (boundaries[boundary] === undefined) {
                this.results.geometric_violations.push({
                    type: 'undefined_boundary',
                    boundary: boundary,
                    message: `Boundary '${boundary}' not defined`,
                    impact: 'medium',
                    fix: `Define '${boundary}' boundary explicitly`
                });
            }
        });
        
        // Check mount configuration geometry
        const mountConfig = config.mount_configuration || {};
        let mountsWithPurpose = 0;
        
        Object.entries(mountConfig).forEach(([mountName, mountDef]) => {
            if (mountDef.purpose) {
                mountsWithPurpose++;
            }
            
            if (!mountDef.mode || !['ro', 'rw'].includes(mountDef.mode)) {
                this.results.geometric_violations.push({
                    type: 'undefined_mount_boundary',
                    mount: mountName,
                    message: `Mount '${mountName}' lacks defined access boundary`,
                    impact: 'medium',
                    fix: 'Specify read-only (ro) or read-write (rw) access mode'
                });
            }
        });
        
        // Geometric resonance requires purposeful mounts
        if (mountsWithPurpose === 0 && Object.keys(mountConfig).length > 0) {
            this.results.geometric_violations.push({
                type: 'purposeless_mounts',
                message: 'Mounts lack geometric purpose definition',
                impact: 'low',
                fix: 'Add purpose field to each mount defining its geometric function'
            });
        }
    }

    async checkConceptualCoherence(config) {
        console.log('🧠 Checking conceptual coherence...');
        
        // Check for coherent concept progression
        const axioms = Object.keys(config.axioms || {});
        const atomicConcepts = Object.keys(config.atomic_concepts || {});
        const conceptualComponents = Object.keys(config.conceptual_components || {});
        
        if (axioms.length === 0) {
            this.results.alignment_issues.push({
                type: 'missing_axioms',
                message: 'No axioms defined - concepts lack foundational basis',
                impact: 'high',
                fix: 'Define fundamental axioms as conceptual foundation'
            });
        }
        
        if (atomicConcepts.length === 0) {
            this.results.alignment_issues.push({
                type: 'missing_atomic_concepts',
                message: 'No atomic concepts defined - missing conceptual building blocks',
                impact: 'high',
                fix: 'Define atomic concepts building from axioms'
            });
        }
        
        // Check coherence ratio (concepts should build progressively)
        const totalConcepts = axioms.length + atomicConcepts.length + conceptualComponents.length;
        if (totalConcepts > 0) {
            const progressionRatio = (axioms.length + atomicConcepts.length) / totalConcepts;
            if (progressionRatio < 0.6) {
                this.results.alignment_issues.push({
                    type: 'top_heavy_concepts',
                    ratio: progressionRatio,
                    message: 'Too many complex concepts relative to foundational concepts',
                    impact: 'medium',
                    fix: 'Add more foundational axioms and atomic concepts'
                });
            }
        }
        
        // Check for FCM compliance terminology
        const configStr = JSON.stringify(config);
        const fcmTerms = ['progressive', 'self-contained', 'resonance', 'evolution', 'formal'];
        let fcmTermCount = 0;
        
        fcmTerms.forEach(term => {
            if (configStr.includes(term)) {
                fcmTermCount++;
            }
        });
        
        if (fcmTermCount < 3) {
            this.results.alignment_issues.push({
                type: 'insufficient_fcm_terminology',
                count: fcmTermCount,
                message: 'Configuration lacks sufficient FCM terminology',
                impact: 'low',
                fix: 'Include more FCM-aligned terminology in definitions'
            });
        }
    }

    async checkEvolutionaryResonance(config) {
        console.log('🔄 Checking evolutionary resonance...');
        
        // Check if evolution tracking exists
        try {
            const evolutionPath = path.join(this.configPath, 'evolution.log.json');
            const evolutionContent = fs.readFileSync(evolutionPath, 'utf8');
            const evolutionLog = JSON.parse(evolutionContent);
            
            // Check evolution-configuration alignment
            if (evolutionLog.current_state && evolutionLog.current_state.fcm_compliance !== true) {
                this.results.alignment_issues.push({
                    type: 'evolution_fcm_mismatch',
                    message: 'Evolution log indicates FCM non-compliance',
                    impact: 'medium',
                    fix: 'Update configuration to achieve FCM compliance'
                });
            }
            
            // Check learning capture
            const recentEvolutions = evolutionLog.evolution_history?.slice(-3) || [];
            const evolutionsWithLearning = recentEvolutions.filter(e => e.learning);
            
            if (evolutionsWithLearning.length < recentEvolutions.length * 0.5) {
                this.results.alignment_issues.push({
                    type: 'insufficient_learning_capture',
                    message: 'Recent evolutions lack sufficient learning documentation',
                    impact: 'low',
                    fix: 'Capture learning insights for each evolution'
                });
            }
            
        } catch (error) {
            this.results.alignment_issues.push({
                type: 'missing_evolution_tracking',
                message: 'No evolution log found - evolution not being tracked',
                impact: 'medium',
                fix: 'Create evolution.log.json to track configuration evolution'
            });
        }
    }

    calculateResonanceScore() {
        let score = 100;
        
        // Deduct for issues
        this.results.alignment_issues.forEach(issue => {
            switch (issue.impact) {
                case 'critical':
                    score -= 25;
                    break;
                case 'high':
                    score -= 15;
                    break;
                case 'medium':
                    score -= 10;
                    break;
                case 'low':
                    score -= 5;
                    break;
            }
        });
        
        this.results.geometric_violations.forEach(violation => {
            switch (violation.impact) {
                case 'critical':
                    score -= 20;
                    break;
                case 'high':
                    score -= 12;
                    break;
                case 'medium':
                    score -= 8;
                    break;
                case 'low':
                    score -= 3;
                    break;
            }
        });
        
        this.results.resonance_score = Math.max(0, score);
    }

    generateRecommendations() {
        // Generate recommendations based on issues found
        const allIssues = [...this.results.alignment_issues, ...this.results.geometric_violations];
        const criticalIssues = allIssues.filter(i => i.impact === 'critical');
        const highIssues = allIssues.filter(i => i.impact === 'high');
        
        if (criticalIssues.length > 0) {
            this.results.recommendations.push({
                priority: 'immediate',
                action: 'Fix critical resonance violations',
                details: 'Address configuration loading and fundamental structure issues',
                impact: 'System may not function correctly without these fixes'
            });
        }
        
        if (highIssues.length > 0) {
            this.results.recommendations.push({
                priority: 'high',
                action: 'Resolve high-impact alignment issues',
                details: 'Address missing foundations and undefined boundaries',
                impact: 'Significantly improves FCM compliance and system resonance'
            });
        }
        
        if (this.results.resonance_score < 70) {
            this.results.recommendations.push({
                priority: 'medium',
                action: 'Improve overall resonance alignment',
                details: 'Add more FCM terminology, improve concept progression',
                impact: 'Enhances system coherence and teachability'
            });
        }
        
        if (this.results.resonance_score >= 85) {
            this.results.recommendations.push({
                priority: 'enhancement',
                action: 'System shows strong resonance - consider advanced patterns',
                details: 'Explore distributed resonance, predictive evolution, community patterns',
                impact: 'Positions system for next-generation FCM implementation'
            });
        }
    }

    reportResults() {
        console.log('\\n🔄 Resonance Alignment Results:');
        console.log('=' .repeat(50));
        
        // Resonance score
        const scoreEmoji = this.results.resonance_score >= 85 ? '🌟' : 
                          this.results.resonance_score >= 70 ? '✅' : 
                          this.results.resonance_score >= 50 ? '⚠️' : '❌';
        
        console.log(`\\n${scoreEmoji} Resonance Score: ${this.results.resonance_score}/100`);
        
        // Group all issues by impact level
        const allIssues = [
            ...this.results.alignment_issues.map(i => ({...i, category: 'Alignment'})),
            ...this.results.geometric_violations.map(v => ({...v, category: 'Geometric'}))
        ];
        
        const criticalIssues = allIssues.filter(i => i.impact === 'critical');
        const highIssues = allIssues.filter(i => i.impact === 'high');
        const mediumIssues = allIssues.filter(i => i.impact === 'medium');
        const lowIssues = allIssues.filter(i => i.impact === 'low');
        
        // Display issues grouped by severity
        if (criticalIssues.length > 0) {
            console.log('\\n🚨 CRITICAL ISSUES:');
            criticalIssues.forEach(issue => {
                console.log(`   [${issue.category}] ${issue.type}: ${issue.message}`);
                console.log(`      💡 Fix: ${issue.fix}\\n`);
            });
        }
        
        if (highIssues.length > 0) {
            console.log('\\n❗ HIGH PRIORITY ISSUES:');
            highIssues.forEach(issue => {
                console.log(`   [${issue.category}] ${issue.type}: ${issue.message}`);
                console.log(`      💡 Fix: ${issue.fix}\\n`);
            });
        }
        
        if (mediumIssues.length > 0) {
            console.log('\\n⚠️  MEDIUM PRIORITY ISSUES:');
            mediumIssues.forEach(issue => {
                console.log(`   [${issue.category}] ${issue.type}: ${issue.message}`);
                console.log(`      💡 Fix: ${issue.fix}\\n`);
            });
        }
        
        if (lowIssues.length > 0) {
            console.log('\\nℹ️  LOW PRIORITY ISSUES:');
            lowIssues.forEach(issue => {
                console.log(`   [${issue.category}] ${issue.type}: ${issue.message}`);
                console.log(`      💡 Fix: ${issue.fix}\\n`);
            });
        }
        
        // Summary line with counts
        console.log('\\n📊 ISSUE SUMMARY:');
        console.log(`   🚨 Critical: ${criticalIssues.length} | ❗ High: ${highIssues.length} | ⚠️  Medium: ${mediumIssues.length} | ℹ️  Low: ${lowIssues.length}`);
        console.log(`   Total Issues: ${allIssues.length}`);
        
        // Recommendations
        if (this.results.recommendations.length > 0) {
            console.log('\\n🎯 Recommendations:');
            this.results.recommendations.forEach(rec => {
                const emoji = rec.priority === 'immediate' ? '🚨' : 
                             rec.priority === 'high' ? '⚡' : 
                             rec.priority === 'medium' ? '📈' : '✨';
                console.log(`   ${emoji} ${rec.priority.toUpperCase()}: ${rec.action}`);
                console.log(`      Details: ${rec.details}`);
                console.log(`      Impact: ${rec.impact}\\n`);
            });
        }
        
        // Overall assessment
        if (this.results.resonance_score >= 85) {
            console.log('\\n🌟 Excellent resonance alignment! System demonstrates strong FCM compliance.');
        } else if (this.results.resonance_score >= 70) {
            console.log('\\n✅ Good resonance alignment. Minor improvements recommended.');
        } else if (this.results.resonance_score >= 50) {
            console.log('\\n⚠️  Moderate resonance. Significant improvements needed for optimal FCM compliance.');
        } else {
            console.log('\\n❌ Low resonance alignment. Major restructuring required for FCM compliance.');
        }
        
        console.log('\\n📚 For detailed guidance, see:');
        console.log('   - FCM Sidecar Pattern: /home/coder/models/fcm.sidecar.md');
        console.log('   - Docker Implementation: /home/coder/models/fcm.docker-bridge.md');
        console.log('   - Configuration Theory: /home/coder/models/fcm.config.md');
        
        return this.results.resonance_score >= 50;
    }

    async saveResults() {
        const resultsPath = path.join(this.configPath, 'resonance.report.json');
        const report = {
            timestamp: new Date().toISOString(),
            resonance_score: this.results.resonance_score,
            alignment_issues: this.results.alignment_issues,
            geometric_violations: this.results.geometric_violations,
            recommendations: this.results.recommendations,
            assessment: this.results.resonance_score >= 85 ? 'excellent' :
                       this.results.resonance_score >= 70 ? 'good' :
                       this.results.resonance_score >= 50 ? 'moderate' : 'poor'
        };
        
        fs.writeFileSync(resultsPath, JSON.stringify(report, null, 2));
        return report;
    }
}

// Main execution
async function main() {
    const checker = new ResonanceChecker();
    
    const success = await checker.checkSystemResonance();
    await checker.saveResults();
    
    process.exit(success ? 0 : 1);
}

// Run if called directly
if (require.main === module) {
    main().catch(error => {
        console.error('❌ Resonance check failed:', error.message);
        process.exit(1);
    });
}

module.exports = ResonanceChecker;