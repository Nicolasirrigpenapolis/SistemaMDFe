import React, { ReactNode, useState } from 'react';

interface FormCardProps {
  title: string;
  icon?: string;
  children: ReactNode;
  collapsible?: boolean;
  defaultExpanded?: boolean;
  className?: string;
}

export const FormCard: React.FC<FormCardProps> = ({
  title,
  icon,
  children,
  collapsible = false,
  defaultExpanded = true,
  className = ''
}) => {
  const [isExpanded, setIsExpanded] = useState(defaultExpanded);

  const toggleExpansion = () => {
    if (collapsible) {
      setIsExpanded(!isExpanded);
    }
  };

  return (
    <div className={`form-card ${className} ${!isExpanded ? 'collapsed' : ''}`}>
      <div 
        className={`form-card-header ${collapsible ? 'clickable' : ''}`}
        onClick={toggleExpansion}
      >
        <div className="form-card-title">
          {icon && <i className={icon}></i>}
          <span>{title}</span>
        </div>
        
        {collapsible && (
          <button className="form-card-toggle" type="button">
            <i className={`icon-chevron-${isExpanded ? 'up' : 'down'}`}></i>
          </button>
        )}
      </div>
      
      {isExpanded && (
        <div className="form-card-body">
          {children}
        </div>
      )}
    </div>
  );
};