import React from 'react';
import { useTheme } from '../../../contexts/ThemeContext';

interface OptionalFieldsToggleProps {
  label: string;
  description?: string;
  isExpanded: boolean;
  onToggle: () => void;
  icon?: string;
  className?: string;
}

export const OptionalFieldsToggle: React.FC<OptionalFieldsToggleProps> = ({
  label,
  description,
  isExpanded,
  onToggle,
  icon = 'fas fa-plus-circle',
  className = ''
}) => {
  const { theme } = useTheme();

  return (
    <div
      className={`optional-fields-toggle ${className}`}
      onClick={onToggle}
      style={{
        display: 'flex',
        alignItems: 'center',
        padding: '12px 16px',
        background: isExpanded ? 'var(--color-primary-light)' : 'var(--color-surface-hover)',
        border: `1px solid ${isExpanded ? 'var(--color-primary)' : 'var(--color-border)'}`,
        borderRadius: '8px',
        cursor: 'pointer',
        marginBottom: '16px',
        transition: 'all 0.2s ease',
        fontSize: '14px',
        fontWeight: '500'
      }}
    >
      <i
        className={isExpanded ? 'fas fa-minus-circle' : icon}
        style={{
          color: isExpanded ? 'var(--color-primary)' : 'var(--color-text-secondary)',
          marginRight: '12px',
          fontSize: '16px',
          transition: 'color 0.2s ease'
        }}
      />
      <div style={{ flex: 1 }}>
        <div style={{
          color: 'var(--color-text-primary)',
          fontWeight: '600',
          transition: 'color 0.2s ease'
        }}>
          {label}
        </div>
        {description && (
          <div style={{
            color: 'var(--color-text-secondary)',
            fontSize: '12px',
            marginTop: '2px',
            transition: 'color 0.2s ease'
          }}>
            {description}
          </div>
        )}
      </div>
      <i
        className={`fas fa-chevron-${isExpanded ? 'up' : 'down'}`}
        style={{
          color: 'var(--color-text-secondary)',
          fontSize: '12px',
          transition: 'color 0.2s ease'
        }}
      />
    </div>
  );
};

interface OptionalSectionProps {
  children: React.ReactNode;
  isVisible: boolean;
  className?: string;
}

export const OptionalSection: React.FC<OptionalSectionProps> = ({
  children,
  isVisible,
  className = ''
}) => {
  const { theme } = useTheme();

  if (!isVisible) return null;

  return (
    <div
      className={`optional-section ${className}`}
      style={{
        background: 'var(--color-surface)',
        border: '1px solid var(--color-border)',
        borderRadius: '8px',
        padding: '20px',
        marginBottom: '16px',
        transition: 'all 0.2s ease'
      }}
    >
      {children}
    </div>
  );
};