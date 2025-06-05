#!/usr/bin/env node

/**
 * FCM Validation Tool
 * Validates configuration files for FCM compliance
 * Implements progressive definition checking and structural validation
 */

const fs = require('fs');
const path = require('path');

// Cache for loaded files to improve performance
const CACHE = {
    validationRules: null,
    evolutionLog: null,
    lastValidationResult: null,
    lastValidationTime: 0
};

const CACHE_TTL = 5000; // 5 seconds cache TTL

class FCMValidator {
    constructor() {
        this.errors = [];
        this.warnings = [];
        this.info = [];
        this.validationRules = null;
        this.configPath = '/home/coder/config';
        this.modelsPath = '/home/coder/models';
    }

    async loadValidationRules() {
        // Use cached rules if available and fresh
        if (CACHE.validationRules) {
            this.validationRules = CACHE.validationRules;
            return true;
        }

        try {
            const rulesPath = path.join(this.configPath, 'validation.rules.json');
            const rulesContent = fs.readFileSync(rulesPath, 'utf8');
            this.validationRules = JSON.parse(rulesContent);
            CACHE.validationRules = this.validationRules; // Cache for future use
            return true;
        } catch (error) {
            this.errors.push({
                rule_id: 'INIT001',
                message: `Cannot load validation rules: ${error.message}`,
                fix_guidance: 'Ensure validation.rules.json exists in config directory'
            });
            return false;
        }
    }

    async validateConfiguration(configFile) {
        // Check cache for recent validation result
        const now = Date.now();
        if (CACHE.lastValidationResult && 
            CACHE.lastValidationTime > now - CACHE_TTL &&
            CACHE.lastValidationResult.configFile === configFile) {
            console.log(`🔍 Using cached validation result for ${configFile}...`);
            this.errors = CACHE.lastValidationResult.errors;
            this.warnings = CACHE.lastValidationResult.warnings;
            this.info = CACHE.lastValidationResult.info;
            return CACHE.lastValidationResult.success;
        }

        console.log(`🔍 Validating FCM compliance for ${configFile}...`);
        
        if (!await this.loadValidationRules()) {
            return false;
        }

        let config;
        try {
            const configPath = path.join(this.configPath, configFile);
            const configContent = fs.readFileSync(configPath, 'utf8');
            config = JSON.parse(configContent);
        } catch (error) {
            this.errors.push({
                rule_id: 'PARSE001',
                message: `Cannot parse configuration: ${error.message}`,
                fix_guidance: 'Check JSON syntax and file accessibility'
            });
            return false;
        }

        // Run validation checks in order
        this.validateStructuralRules(config);
        this.validateConceptualRules(config);
        this.validateRelationalRules(config);
        this.validateEvolutionaryRules(config);

        const success = this.reportResults();
        
        // Cache the validation result
        CACHE.lastValidationResult = {
            configFile,
            success,
            errors: [...this.errors],
            warnings: [...this.warnings],
            info: [...this.info]
        };
        CACHE.lastValidationTime = Date.now();
        
        return success;
    }

    validateStructuralRules(config) {
        console.log('📋 Checking structural rules...');
        
        // S001: Progressive Definition
        if (config.atomic_concepts) {
            this.checkProgressiveDefinition(config.atomic_concepts, config.axioms || {});
        }
        
        // S002: Self-Containment
        this.checkSelfContainment(config);
        
        // S003: Concept Hierarchy
        this.checkConceptHierarchy(config);
    }

    validateConceptualRules(config) {
        console.log('🧠 Checking conceptual rules...');
        
        // C001: Sidecar Compliance
        if (config.sidecar_configuration) {
            this.checkSidecarCompliance(config.sidecar_configuration);
        }
        
        // C002: Boundary Preservation
        if (config.mount_configuration) {
            this.checkBoundaryPreservation(config.mount_configuration);
        }
        
        // C003: Autonomy Maintenance
        this.checkAutonomyMaintenance(config);
    }

    validateRelationalRules(config) {
        console.log('🔗 Checking relational rules...');
        
        // R001: Lateral Relationships
        this.checkLateralRelationships(config);
        
        // R002: Interface Clarity
        this.checkInterfaceClarity(config);
        
        // R003: Coupling Minimization
        this.checkCouplingMinimization(config);
    }

    validateEvolutionaryRules(config) {
        console.log('🔄 Checking evolutionary rules...');
        
        // Load evolution log if available (with caching)
        let evolutionLog = CACHE.evolutionLog;
        
        if (!evolutionLog) {
            try {
                const evolutionPath = path.join(this.configPath, 'evolution.log.json');
                const evolutionContent = fs.readFileSync(evolutionPath, 'utf8');
                evolutionLog = JSON.parse(evolutionContent);
                CACHE.evolutionLog = evolutionLog;
            } catch (error) {
                this.info.push({
                    rule_id: 'E000',
                    message: 'Evolution log not found - skipping evolutionary validation',
                    fix_guidance: 'Create evolution.log.json to track configuration evolution'
                });
                return;
            }
        }
        
        // E001: Identity Preservation
        this.checkIdentityPreservation(config, evolutionLog);
        
        // E002: Backward Compatibility
        this.checkBackwardCompatibility(config, evolutionLog);
        
        // E003: Learning Capture
        this.checkLearningCapture(evolutionLog);
    }

    checkProgressiveDefinition(concepts, axioms) {
        const defined = new Set(Object.keys(axioms));
        
        for (const [conceptName, conceptDef] of Object.entries(concepts)) {
            if (conceptDef.requires) {
                for (const dependency of conceptDef.requires) {
                    if (!defined.has(dependency)) {
                        this.errors.push({
                            rule_id: 'S001',
                            message: `Concept '${conceptName}' references undefined concept '${dependency}'`,
                            fix_guidance: `Define '${dependency}' before '${conceptName}' or include in axioms`,
                            concept: conceptName,
                            dependency: dependency
                        });
                    }
                }
            }
            defined.add(conceptName);
        }
    }

    checkSelfContainment(config) {
        // Check for external references that aren't in axioms or defined concepts
        const allDefined = new Set([
            ...Object.keys(config.axioms || {}),
            ...Object.keys(config.atomic_concepts || {}),
            ...Object.keys(config.conceptual_components || {})
        ]);

        // This is a simplified check - in practice would need deeper analysis
        const configStr = JSON.stringify(config);
        const externalRefs = configStr.match(/"[a-z_]+_external"/g);
        
        if (externalRefs) {
            externalRefs.forEach(ref => {
                const cleanRef = ref.replace(/"/g, '').replace('_external', '');
                if (!allDefined.has(cleanRef)) {
                    this.errors.push({
                        rule_id: 'S002',
                        message: `Configuration references external concept '${cleanRef}'`,
                        fix_guidance: `Define '${cleanRef}' within configuration or include in axioms`
                    });
                }
            });
        }
    }

    checkConceptHierarchy(config) {
        // Verify concepts appear in correct layers
        const layers = ['axioms', 'atomic_concepts', 'conceptual_components'];
        
        for (let i = 1; i < layers.length; i++) {
            const currentLayer = config[layers[i]];
            if (currentLayer) {
                for (const [conceptName, conceptDef] of Object.entries(currentLayer)) {
                    if (conceptDef.requires) {
                        conceptDef.requires.forEach(dependency => {
                            // Check if dependency appears in later layer (violation)
                            for (let j = i + 1; j < layers.length; j++) {
                                if (config[layers[j]] && config[layers[j]][dependency]) {
                                    this.warnings.push({
                                        rule_id: 'S003',
                                        message: `Concept '${conceptName}' references '${dependency}' from later layer`,
                                        fix_guidance: `Move '${dependency}' to earlier layer or restructure dependencies`
                                    });
                                }
                            }
                        });
                    }
                }
            }
        }
    }

    checkSidecarCompliance(sidecarConfig) {
        // Check for embedded relationships
        if (sidecarConfig.relationship && sidecarConfig.relationship.includes('within')) {
            this.errors.push({
                rule_id: 'C001',
                message: `Sidecar configuration creates embedded relationship`,
                fix_guidance: 'Maintain beside relationship, not within relationship'
            });
        }

        // Check for proper boundary definition
        if (!sidecarConfig.boundaries) {
            this.warnings.push({
                rule_id: 'C001',
                message: 'Sidecar configuration lacks explicit boundary definition',
                fix_guidance: 'Add boundaries section to define isolation mechanisms'
            });
        }
    }

    checkBoundaryPreservation(mountConfig) {
        for (const [mountName, mountDef] of Object.entries(mountConfig)) {
            // Check for proper isolation
            if (!mountDef.mode || !['ro', 'rw'].includes(mountDef.mode)) {
                this.warnings.push({
                    rule_id: 'C002',
                    message: `Mount '${mountName}' lacks explicit access mode`,
                    fix_guidance: 'Specify read-only (ro) or read-write (rw) access mode'
                });
            }

            // Check for validation definition
            if (!mountDef.validation) {
                this.info.push({
                    rule_id: 'C002',
                    message: `Mount '${mountName}' lacks validation criteria`,
                    fix_guidance: 'Add validation field to specify mount requirements'
                });
            }
        }
    }

    checkAutonomyMaintenance(config) {
        if (config.sidecar_configuration && config.sidecar_configuration.lifecycle) {
            const lifecycle = config.sidecar_configuration.lifecycle;
            const requiredPhases = ['startup', 'runtime', 'shutdown'];
            
            requiredPhases.forEach(phase => {
                if (!lifecycle[phase]) {
                    this.warnings.push({
                        rule_id: 'C003',
                        message: `Lifecycle missing '${phase}' phase definition`,
                        fix_guidance: `Add '${phase}' phase to ensure autonomous operation`
                    });
                }
            });
        }
    }

    checkLateralRelationships(config) {
        // Check for hierarchical patterns in configuration
        const configStr = JSON.stringify(config);
        const hierarchicalPatterns = ['parent', 'child', 'master', 'slave', 'owner'];
        
        hierarchicalPatterns.forEach(pattern => {
            if (configStr.includes(pattern)) {
                this.warnings.push({
                    rule_id: 'R001',
                    message: `Configuration contains hierarchical pattern '${pattern}'`,
                    fix_guidance: 'Use lateral relationship patterns (peer, beside, coordinated)'
                });
            }
        });
    }

    checkInterfaceClarity(config) {
        // Check if mount configurations define clear interfaces
        if (config.mount_configuration) {
            for (const [mountName, mountDef] of Object.entries(config.mount_configuration)) {
                if (!mountDef.purpose) {
                    this.warnings.push({
                        rule_id: 'R002',
                        message: `Mount '${mountName}' lacks purpose definition`,
                        fix_guidance: 'Add purpose field to clarify interface function'
                    });
                }
            }
        }
    }

    checkCouplingMinimization(config) {
        // Simple coupling check - count cross-references
        let couplingScore = 0;
        
        if (config.conceptual_components) {
            for (const [compName, compDef] of Object.entries(config.conceptual_components)) {
                if (compDef.requires) {
                    couplingScore += compDef.requires.length;
                }
            }
        }

        if (couplingScore > 10) {
            this.info.push({
                rule_id: 'R003',
                message: `High coupling detected (score: ${couplingScore})`,
                fix_guidance: 'Consider reducing dependencies between components'
            });
        }
    }

    checkIdentityPreservation(config, evolutionLog) {
        if (config.sidecar_configuration && config.sidecar_configuration.identity) {
            const currentIdentity = config.sidecar_configuration.identity.pattern;
            const lastEvolution = evolutionLog.evolution_history[evolutionLog.evolution_history.length - 1];
            
            if (lastEvolution && lastEvolution.description && !lastEvolution.description.includes(currentIdentity)) {
                this.warnings.push({
                    rule_id: 'E001',
                    message: 'Evolution may have changed core identity pattern',
                    fix_guidance: 'Verify that core identity is preserved through evolution'
                });
            }
        }
    }

    checkBackwardCompatibility(config, evolutionLog) {
        if (evolutionLog.current_state && evolutionLog.current_state.version) {
            const version = evolutionLog.current_state.version;
            const [major] = version.split('.');
            
            // Simple check - within same major version should be compatible
            if (evolutionLog.evolution_history.length > 1) {
                const previousVersions = evolutionLog.evolution_history
                    .map(h => h.version)
                    .filter(v => v.split('.')[0] === major);
                
                if (previousVersions.length > 1) {
                    this.info.push({
                        rule_id: 'E002',
                        message: `${previousVersions.length} versions in major version ${major}`,
                        fix_guidance: 'Ensure backward compatibility within major version'
                    });
                }
            }
        }
    }

    checkLearningCapture(evolutionLog) {
        if (evolutionLog.evolution_history) {
            const recentEvolutions = evolutionLog.evolution_history.slice(-3);
            
            recentEvolutions.forEach((evolution, index) => {
                if (!evolution.learning) {
                    this.warnings.push({
                        rule_id: 'E003',
                        message: `Evolution ${evolution.version} lacks learning documentation`,
                        fix_guidance: 'Add learning field to document insights from evolution'
                    });
                }
            });
        }
    }

    reportResults() {
        console.log('\\n📊 FCM Validation Results:');
        console.log('=' .repeat(50));
        
        if (this.errors.length > 0) {
            console.log('\\n❌ ERRORS:');
            this.errors.forEach(error => {
                console.log(`   ${error.rule_id}: ${error.message}`);
                console.log(`   💡 Fix: ${error.fix_guidance}\\n`);
            });
        }

        if (this.warnings.length > 0) {
            console.log('\\n⚠️  WARNINGS:');
            this.warnings.forEach(warning => {
                console.log(`   ${warning.rule_id}: ${warning.message}`);
                console.log(`   💡 Fix: ${warning.fix_guidance}\\n`);
            });
        }

        if (this.info.length > 0) {
            console.log('\\nℹ️  INFO:');
            this.info.forEach(info => {
                console.log(`   ${info.rule_id}: ${info.message}`);
                console.log(`   💡 Suggestion: ${info.fix_guidance}\\n`);
            });
        }

        const hasErrors = this.errors.length > 0;
        const hasWarnings = this.warnings.length > 0;

        if (!hasErrors && !hasWarnings) {
            console.log('\\n✅ Configuration is FCM compliant!');
        } else if (hasErrors) {
            console.log('\\n❌ Configuration has FCM compliance errors.');
            console.log('Fix errors before proceeding.');
        } else {
            console.log('\\n⚠️  Configuration has warnings but is functional.');
            console.log('Consider addressing warnings for better FCM compliance.');
        }

        console.log('\\n📚 For detailed explanations, see:');
        console.log('   - Sidecar pattern: /home/coder/models/fcm.sidecar.md');
        console.log('   - Docker bridge: /home/coder/models/fcm.docker-bridge.md');
        console.log('   - Configuration: /home/coder/models/fcm.config.md');

        return !hasErrors;
    }

    async generateReport() {
        const report = {
            validation_result: this.errors.length === 0 ? (this.warnings.length === 0 ? 'pass' : 'warnings') : 'fail',
            timestamp: new Date().toISOString(),
            rules_checked: Object.keys(this.validationRules?.structural_rules || {}).length +
                         Object.keys(this.validationRules?.conceptual_rules || {}).length +
                         Object.keys(this.validationRules?.relational_rules || {}).length +
                         Object.keys(this.validationRules?.evolutionary_rules || {}).length,
            errors: this.errors,
            warnings: this.warnings,
            info: this.info,
            summary: {
                total_issues: this.errors.length + this.warnings.length + this.info.length,
                error_count: this.errors.length,
                warning_count: this.warnings.length,
                info_count: this.info.length
            }
        };

        // Write report to file
        const reportPath = path.join(this.configPath, 'validation.report.json');
        fs.writeFileSync(reportPath, JSON.stringify(report, null, 2));
        
        return report;
    }
}

// Main execution
async function main() {
    const validator = new FCMValidator();
    
    // Validate main FCM configuration
    const success = await validator.validateConfiguration('claude.config.fcm.json');
    
    // Generate detailed report
    await validator.generateReport();
    
    // Exit with appropriate code
    process.exit(success ? 0 : 1);
}

// Run if called directly
if (require.main === module) {
    main().catch(error => {
        console.error('❌ Validation failed:', error.message);
        process.exit(1);
    });
}

module.exports = FCMValidator;