import React from 'react';

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
  return (
    <div
      className={`optional-fields-toggle ${className}`}
      onClick={onToggle}
      style={{
        display: 'flex',
        alignItems: 'center',
        padding: '12px 16px',
        background: isExpanded ? '#f0f8ff' : '#f8fafc',
        border: `1px solid ${isExpanded ? '#0284c7' : '#e2e8f0'}`,
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
          color: isExpanded ? '#0284c7' : '#6b7280',
          marginRight: '12px',
          fontSize: '16px'
        }}
      />
      <div style={{ flex: 1 }}>
        <div style={{ color: '#374151', fontWeight: '600' }}>{label}</div>
        {description && (
          <div style={{
            color: '#6b7280',
            fontSize: '12px',
            marginTop: '2px'
          }}>
            {description}
          </div>
        )}
      </div>
      <i
        className={`fas fa-chevron-${isExpanded ? 'up' : 'down'}`}
        style={{
          color: '#6b7280',
          fontSize: '12px'
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
  if (!isVisible) return null;

  return (
    <div
      className={`optional-section ${className}`}
      style={{
        background: '#fafbfc',
        border: '1px solid #e2e8f0',
        borderRadius: '8px',
        padding: '20px',
        marginBottom: '16px'
      }}
    >
      {children}
    </div>
  );
};